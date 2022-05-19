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
    private let channelManager: ChannelManager?
    private let keysManager: KeysManager? = nil
    
    init(channelManager: ChannelManager?, dataService: ILightningDataService) {
        self.channelManager = channelManager
        self.dataService = dataService
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
                
                if let rawTx = PolarConnectionExperiment.shared.bitcoinAdapter.createRawTransaction(amountSat: amount, address: addк.stringValue, feeRate: 10, sortMode: .shuffle) {
                 
                    let rawTxBytes = rawTx.bytes
                    let tcid = fundingReadyEvent.getTemporary_channel_id()

                    if let sendingFundingTx = channelManager?.funding_transaction_generated(temporary_channel_id: tcid, funding_transaction: rawTxBytes) {
                        if sendingFundingTx.isOk() {
                            print("funding tx sent")
                        } else if let errorDetails = sendingFundingTx.getError() {
                            print("sending failed!")
                            
                            switch errorDetails {
                            case .channel_unavailable(err: "channel unavalibale"):
                                print("channel unavalibale")
                            case .fee_rate_too_high(err: "fee rate too hight", feerate: 1):
                                print("fee rate too hight")
                            case .apimisuse_error(err: "Api missuse"):
                                print("Api missuse")
                            case .route_error(err: "Route error"):
                                print("route error")
                            case .monitor_update_failed():
                                print("Monitor update failed")
                            default:
                                print("idk error")
                            }
                        }
                        
                    }
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
    }
    
    override func persist_manager(channel_manager: ChannelManager) -> Result_NoneErrorZ {
        print("PERSIST CHANNEL MANAGER")

        let managerBytes = channel_manager.write()
        dataService.save(channelManager: Data(managerBytes))
        
        return Result_NoneErrorZ.ok()
    }
    
    override func persist_graph(network_graph: NetworkGraph) -> Result_NoneErrorZ {
        print("PERSIST NET GRAPH")

        let netGraphBytes = network_graph.write()
        dataService.save(networkGraph: Data(netGraphBytes))
        
        return Result_NoneErrorZ.ok()
    }
}
