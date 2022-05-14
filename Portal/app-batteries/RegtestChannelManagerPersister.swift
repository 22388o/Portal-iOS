//
//  MyChannelManagerPersister.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/27/21.
//

import Foundation
import BitcoinCore

extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}

class RegtestChannelManagerPersister : Persister, ExtendedChannelManagerPersister {
    
    private let channelManager: ChannelManager?
    private let keysManager: KeysManager? = nil
    
    init(channelManager: ChannelManager?) {
        self.channelManager = channelManager
        super.init()
    }
    
    func handle_event(event: Event) {
        privateHandleEvent(event: event)
    }
    
    
    func convertRouteHop(path: [LDKRouteHop]) {
        let wrappedPath = path.map { (h) in RouteHop(pointer: h) }
    }
    
    
    private func privateHandleEvent(event: Event) {
        switch event.getValueType() {
        case .ChannelClosed:
            print("channel closed")
            if let value = event.getValueAsChannelClosed() {
                let reason = value.getReason()
                switch reason.getValueType() {
                case .ProcessingError:
                    print(reason.getValueAsProcessingError()?.getErr() ?? "Unknown")
                case .CounterpartyForceClosed:
                    print(reason.getValueAsCounterpartyForceClosed()?.getPeer_msg() ?? "Unknown")
                case .none:
                    break
                }
            }
        case .DiscardFunding:
            print("Discard funding")
        case .FundingGenerationReady:
            print("FundingGenerationReady")
            if let fundingReadyEvent = event.getValueAsFundingGenerationReady() {
                let outputScript = fundingReadyEvent.getOutput_script()
                
                let amount = fundingReadyEvent.getChannel_value_satoshis()
                
                let scriptConverter = ScriptConverter()
                let addressConverter = SegWitBech32AddressConverter(prefix: "tb", scriptConverter: scriptConverter)
                
                let addк = try! addressConverter.convert(keyHash: Data(outputScript), type: .p2wsh)
                print(addк)
                print(addк.stringValue)
                
                if let rawTx = PolarConnectionExperiment.shared.btcAdapter.createRawTransaction(amountSat: amount, address: addк.stringValue, feeRate: 10, sortMode: .shuffle) {
                 
                    let rawTxBytes = rawTx.bytes
                    let tcid = fundingReadyEvent.getTemporary_channel_id()

//                    if let sendingFundingTx = channelManager?.funding_transaction_generated(temporary_channel_id: tcid, funding_transaction: rawTxBytes) {
//                        
//                        if sendingFundingTx.isOk() {
//                            print("funding tx sent")
//                        } else if let errorDetails = sendingFundingTx.getError() {
//                            print("sending failed!")
//                            
//                            switch errorDetails {
//                            case .channel_unavailable(err: "channel unavalibale"):
//                                print("channel unavalibale")
//                            case .fee_rate_too_high(err: "fee rate too hight", feerate: 1):
//                                print("fee rate too hight")
//                            case .apimisuse_error(err: "Api missuse"):
//                                print("Api missuse")
//                            case .route_error(err: "Route error"):
//                                print("route error")
//                            case .monitor_update_failed():
//                                print("Monitor update failed")
//                            default:
//                                print("idk error")
//                            }
//                        }
//                        
//                    }
                }
                
            }
        case .PaymentReceived:
            print("PaymentReceived")
        case .PaymentSent:
            print("PaymentSent")
        case .PaymentPathFailed:
            print("PaymentPathFailed")
        case .PaymentFailed:
            print("PaymentFailed")
        case .PendingHTLCsForwardable:
            print("PendingHTLCsForwardable")
        case .SpendableOutputs:
            print("SpendableOutputs")
        case .PaymentForwarded:
            print("PaymentForwarded")
        case .PaymentPathSuccessful:
            print("PaymentPathSuccessful")
        case .OpenChannelRequest:
            print("OpenChannelRequest")
        case .none:
            print("none")
        }
        
//        if let spendableOutputEvent = event.getValueAsSpendableOutputs() {
//
//            let outputs = spendableOutputEvent.getOutputs()
//
//            let fastFeerate = 7500
//            let destinationScriptHardcoded: [UInt8] = [118,169,20,25,18,157,83,230,49,155,175,25,219,160,89,190,173,22,109,249,10,184,245,136,172]
//
//            guard let result = self.keysManager?.spend_spendable_outputs(descriptors: outputs, outputs: [], change_destination_script: destinationScriptHardcoded, feerate_sat_per_1000_weight: UInt32(fastFeerate)) else {
//                return
//            }
//
//            if let transaction = result.getValue() {
//                // sendEvent(eventName: MARKER_BROADCAST, eventBody: ["txhex": bytesToHex(bytes: transaction)])
//            }
//
//            return
//
//        }else if let paymentSentEvent = event.getValueAsPaymentSent() {
//            // print what needs printing
//        }else if let pendingHTLCsForwardableEvent = event.getValueAsPendingHTLCsForwardable() {
//            channelManager?.process_pending_htlc_forwards()
//
//
//
//            // LDKC2Tuple_usizeTransactionZ(a: <#T##UInt#>, b: <#T##LDKTransaction#>)
//            // channelManager?.as_Confirm().transactions_confirmed(header: <#T##[UInt8]?#>, txdata: <#T##[LDKC2Tuple_usizeTransactionZ]#>, height: <#T##UInt32#>)
//
//            // C2Tuple_usizeTransactionZ_new(<#T##a: UInt##UInt#>, <#T##b: LDKTransaction##LDKTransaction#>)
//
//
//
//
//        } else if let fundingReadyEvent = event.getValueAsFundingGenerationReady() {
//            let outputScript = fundingReadyEvent.getOutput_script()
//            let amount = fundingReadyEvent.getChannel_value_satoshis()
//
//            print("ready stuff: \(amount) to  \(outputScript)")
//            print("funding event ready!")
//
//            let url = URL(string: "http://localhost:3000/api/lab/funding-generation-ready")!
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//
//            let tcid = fundingReadyEvent.getTemporary_channel_id()
//
//            components.queryItems = [
//                URLQueryItem(name: "script", value: "\(outputScript)"),
//                URLQueryItem(name: "amount", value: "\(amount)"),
//                URLQueryItem(name: "tcid", value: "\(fundingReadyEvent.getTemporary_channel_id())"),
//                URLQueryItem(name: "ucid", value: "\(fundingReadyEvent.getUser_channel_id())")
//            ]
//
//            let query = components.url!.query
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.httpBody = Data(query!.utf8)
//
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: request, completionHandler: { data, response, error in
//                print("received local funding generation ready response")
//            })
//            task.resume()
//        }
    }
    
    override func persist_manager(channel_manager: ChannelManager) -> Result_NoneErrorZ {
        
         let managerBytes = channel_manager.write()
         let defaults = UserDefaults.standard
         defaults.setValue(Data(managerBytes), forKey: "manager")
         print("PERSIST CHANNEL MANAGER:\n\n\(managerBytes)\n\n")
         
        return Result_NoneErrorZ.ok()
    }
    
    override func persist_graph(network_graph: NetworkGraph) -> Result_NoneErrorZ {
        print("Persisi net graph")
        
        
        return Result_NoneErrorZ.ok()
    }
}
