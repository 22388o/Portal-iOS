//
//  MyPersister.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/17/21.
//

import Foundation

class ChannelPersister: Persist {
    let dataService: ILightningDataService
    
    func readChannelMonitors() {

    }
    
    init(dataService: ILightningDataService) {
        self.dataService = dataService
        super.init()
    }
    
    override func persist_new_channel(channel_id: OutPoint, data: ChannelMonitor, update_id: MonitorUpdateId) -> Result_NoneChannelMonitorUpdateErrZ {
        let idBytes: [UInt8] = channel_id.write()
        let monitorBytes: [UInt8] = data.write()
        
        dataService.update(channelMonitor: Data(monitorBytes), id: Data(idBytes).hex)
                
        return Result_NoneChannelMonitorUpdateErrZ.ok()
    }
    
    override func update_persisted_channel(channel_id: OutPoint, update: ChannelMonitorUpdate, data: ChannelMonitor, update_id: MonitorUpdateId) -> Result_NoneChannelMonitorUpdateErrZ {
        let idBytes: [UInt8] = channel_id.write()
        let monitorBytes: [UInt8] = data.write()

        dataService.update(channelMonitor: Data(monitorBytes), id: Data(idBytes).hex)
        
        return Result_NoneChannelMonitorUpdateErrZ.ok()
    }
    
}
