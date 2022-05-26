//
//  ChannelManagerPersister.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/27/21.
//

import Foundation
import BitcoinCore

class ChannelManagerPersister : Persister, ExtendedChannelManagerPersister {
    private let dataService: ILightningDataService
    private let channelManager: ChannelManager
    
    init(channelManager: ChannelManager, dataService: ILightningDataService) {
        self.channelManager = channelManager
        self.dataService = dataService
        super.init()
    }
    
    func handle_event(event: Event) {
        switch event.getValueType() {
        case .ChannelClosed:
            print("==============")
            print("CHANNEL CLOSED")
            print("==============")

            if let value = event.getValueAsChannelClosed() {
                let channelId = value.getUser_channel_id()
                dataService.removeChannelWith(id: channelId)
                
                let id = LDKBlock.bytesToHexString(bytes: value.getChannel_id())
                let errorMessage: String
                
                let reason = value.getReason()
                switch reason.getValueType() {
                case .ProcessingError:
                    let closingReasonMessage = "\(reason.getValueAsProcessingError()?.getErr() ?? "Unknown")"
                    print("reason: \(closingReasonMessage)")
                    errorMessage = "Channel \(id) closed: \(closingReasonMessage)"
                case .CounterpartyForceClosed:
                    let closingReasonMessage = "\(reason.getValueAsCounterpartyForceClosed()?.getPeer_msg() ?? "Unknown")"
                    print("reason: \(closingReasonMessage)")
                    errorMessage = "Channel \(id) closed: \(closingReasonMessage)"
                case .none:
                    errorMessage = "Channel \(id) closed: Unknown"
                }
                
                PolarConnectionExperiment.shared.userMessage = errorMessage
            }
        case .DiscardFunding:
            print("================")
            print("DISCARD FUNDING")
            print("================")
            
            if let value = event.getValueAsDiscardFunding() {
                let channelId = LDKBlock.bytesToHexString(bytes: value.getChannel_id())
                print("Channel id: \(channelId)")
                let errorMsg = "Channel \(channelId) closed: DISCARD FUNDING"
                PolarConnectionExperiment.shared.userMessage = errorMsg
            }
        case .FundingGenerationReady:
            print("=========================")
            print("FUNDING GENERATION READY")
            print("=========================")
            
            if let fundingReadyEvent = event.getValueAsFundingGenerationReady() {
                let outputScript = fundingReadyEvent.getOutput_script()
                let amount = fundingReadyEvent.getChannel_value_satoshis()
                let channelId = fundingReadyEvent.getUser_channel_id()

                do {
                    if let rawTx = try PolarConnectionExperiment.shared.createRawTransaction(outputScript: outputScript, amount: amount) {
                        let rawTxBytes = rawTx.bytes
                        let tcid = fundingReadyEvent.getTemporary_channel_id()
                        
                        let sendingFundingTx = channelManager.funding_transaction_generated(
                            temporary_channel_id: tcid,
                            funding_transaction: rawTxBytes
                        )
                        
                        
                        if sendingFundingTx.isOk() {
                            print("funding tx sent")
                            let userMessage = "Chanel is open. Waiting funding tx to be confirmed"
                            PolarConnectionExperiment.shared.userMessage = userMessage
                        } else if let errorDetails = sendingFundingTx.getError() {
                            print("sending failed")
                            
                            dataService.removeChannelWith(id: channelId)
                            
                            let errorMessage: String
                            
                            switch errorDetails {
                            case .channel_unavailable(err: "channel unavalibale"):
                                print("channel unavalibale")
                                let details = errorDetails.getValueAsChannelUnavailable()?.getErr()
                                errorMessage = "Cannot send funding transaction: Channel unavalibale \(String(describing: details))"
                            case .fee_rate_too_high(err: "fee rate too hight", feerate: 1):
                                print("fee rate too hight")
                                errorMessage = "Cannot send funding transaction: Fee rate too hight"
                            case .apimisuse_error(err: "Api missuse"):
                                print("Api missuse")
                                let details = errorDetails.getValueAsAPIMisuseError()?.getErr()
                                errorMessage = "Cannot send funding transaction: Api missuse \(String(describing: details))"
                            case .route_error(err: "Route error"):
                                print("route error")
                                let details = errorDetails.getValueAsRouteError()?.getErr()
                                errorMessage = "Cannot send funding transaction: Route error \(String(describing: details))"
                            case .monitor_update_failed():
                                print("Monitor update failed")
                                errorMessage = "Cannot send funding transaction: Monitor update failed"
                            default:
                                errorMessage = "Cannot send funding transaction: Unknown error"
                            }
                            
                            PolarConnectionExperiment.shared.userMessage = errorMessage
                        }
                    }
                } catch {
                    print("Unable to create funding transactino error: \(error)")
                    dataService.removeChannelWith(id: channelId)
                    let errorMsg = "Unable to create funding transactino error: \(error)"
                    PolarConnectionExperiment.shared.userMessage = errorMsg
                }
            }
        case .PaymentReceived:
            print("==================")
            print("PAYMENT RECEIVED")
            print("==================")
            
            if let value = event.getValueAsPaymentReceived() {
                let amount = value.getAmt()
                print("Amount: \(amount)")
                let paymentId = LDKBlock.bytesToHexString(bytes: value.getPayment_hash())
                print("Payment id: \(paymentId)")
                
                let paymentPurpose = value.getPurpose()
                let invoicePayment = paymentPurpose.getValueAsInvoicePayment()!
                let preimage = invoicePayment.getPayment_preimage()
                let claimResult = channelManager.claim_funds(payment_preimage: preimage)
                
                let userMessage: String
                
                if claimResult {
                    print("Claimed")
                    let payment = LightningPayment(id: paymentId, satAmount: Int64(amount), created: Date(), memo: "incoming payment", state: .recieved)
                    dataService.save(payment: payment)
                    userMessage = "Payment received: \(amount) sat"
                } else {
                    print("CLAIMING ERROR")
                    userMessage = "Claming funds error: \(amount) sat"
                }
                
                PolarConnectionExperiment.shared.userMessage = userMessage
            }
        case .PaymentSent:
            print("==============")
            print("PAYMENT SENT")
            print("==============")
            
            if let value = event.getValueAsPaymentSent() {
                let paymentID = value.getPayment_id()
                let paymentHash = value.getPayment_hash()
            }
        case .PaymentPathFailed:
            print("====================")
            print("PAYMENT PATH FAILED")
            print("====================")
            
            let errorMessage: String
            
            if let value = event.getValueAsPaymentPathFailed() {
                print("Is rejected by destination: \(value.getRejected_by_dest())")
                print("All paths failed: \(value.getAll_paths_failed())")
                errorMessage = "Payment path failed: Is rejected - \(value.getRejected_by_dest()), all paths failed - \(value.getAll_paths_failed())"
            } else {
                errorMessage = "Payment path failed"
            }
            
            PolarConnectionExperiment.shared.userMessage = errorMessage
            
        case .PaymentFailed:
            print("================")
            print("PAYMENT FAILED")
            print("================")
            
            if let value = event.getValueAsPaymentFailed() {
                print("Payment id: \(LDKBlock.bytesToHexString(bytes: value.getPayment_id()))")
            }
        case .PendingHTLCsForwardable:
            print("=========================")
            print("PendingHTLCsForwardable")
            print("=========================")
            
            channelManager.process_pending_htlc_forwards()
        case .SpendableOutputs:
            print("=================")
            print("SpendableOutputs")
            print("=================")
        case .PaymentForwarded:
            print("=================")
            print("PaymentForwarded")
            print("=================")
        case .PaymentPathSuccessful:
            print("======================")
            print("PaymentPathSuccessful")
            print("======================")
        case .OpenChannelRequest:
            print("====================")
            print("OpenChannelRequest")
            print("====================")
        case .none:
            print("none")
        }
    }
        
    override func persist_manager(channel_manager: ChannelManager) -> Result_NoneErrorZ {
        print("========================")
        print("PERSIST CHANNEL MANAGER")
        print("========================")
        
        let managerBytes = channel_manager.write()
        dataService.save(channelManager: Data(managerBytes))
        
        print("OUR NODE ID: \(LDKBlock.bytesToHexString(bytes: channel_manager.get_our_node_id()))")
        print("Avaliable channels: \(channel_manager.list_channels().count)")
        
        DispatchQueue.global(qos: .background).async {
            for channel in channel_manager.list_channels() {
                let userChannelID = channel.get_user_channel_id()
                let balance = channel.get_balance_msat()/1000
                
                print("CHANNEL ID: \(LDKBlock.bytesToHexString(bytes: channel.get_channel_id()))")
                print("CHANNEL USER ID \(userChannelID)")
                print("CHANNEL BALANCE: \(balance) sat")
                
                if channel.get_is_usable() {
                    print("CHANNEL IS USABLE")
                    
                    if let fetchedChannel = self.dataService.channelWith(id: userChannelID),
                        fetchedChannel.state != .open ||
                        fetchedChannel.satValue != balance
                    {
                        fetchedChannel.state = .open
                        fetchedChannel.satValue = balance
                        
                        self.dataService.update(channel: fetchedChannel)
                    }
                } else {
                    print("CHANNEL IS UNUSABLE")
                    print("confirmation required: \(String(describing: channel.get_confirmations_required().getValue()))")
                    
                    if let fetchedChannel = self.dataService.channelWith(id: userChannelID),
                        fetchedChannel.state != .waitingFunds ||
                        fetchedChannel.satValue != balance
                    {
                        fetchedChannel.state = .waitingFunds
                        fetchedChannel.satValue = balance
                        
                        self.dataService.update(channel: fetchedChannel)
                    }
                }
            }
        }
        
        return Result_NoneErrorZ.ok()
    }
    
    override func persist_graph(network_graph: NetworkGraph) -> Result_NoneErrorZ {
        print("PERSIST NET GRAPH")

        let netGraphBytes = network_graph.write()
        dataService.save(networkGraph: Data(netGraphBytes))
        
        return Result_NoneErrorZ.ok()
    }
}
