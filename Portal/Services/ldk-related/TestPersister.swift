//
//  MyPersister.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/17/21.
//

import Foundation

class TestPersister: Persist {
    
    func readChannelMonitors() {
//        if var channelsDict = UserDefaults.standard.object(forKey: "channelMonitors") as? [[String:Data]] {
//            for monitorData in channelsDict {
//                let idBytes: [UInt8] = channelsDict["monitorID"].bytes
//                let monitorData: [UInt8] = channelsDict["monitorData"].bytes
////                let mon = ChannelMonitor(pointer: LDKChannelMonitor(channel_id: idBytes, data: monitorData, update_id: 12))
//            }
//        }
    }
    
    override func persist_new_channel(channel_id: OutPoint, data: ChannelMonitor, update_id: MonitorUpdateId) -> Result_NoneChannelMonitorUpdateErrZ {
        let idBytes: [UInt8] = channel_id.write()
        let monitorBytes: [UInt8] = data.write()
        
        let defaults = UserDefaults.standard
        
        if var channelsDict = defaults.object(forKey: "channelMonitors") as? [[String:Data]] {
            channelsDict.append(
                ["monitorID" : Data(idBytes),
                 "monitorData" : Data(monitorBytes)]
            )
        } else {
            let monitorsData = [["monitorID" : Data(idBytes), "monitorData" : Data(monitorBytes)]]
            defaults.set(monitorsData, forKey: "channelMonitors")
        }
        
        return Result_NoneChannelMonitorUpdateErrZ.ok()
    }
    
    override func update_persisted_channel(channel_id: OutPoint, update: ChannelMonitorUpdate, data: ChannelMonitor, update_id: MonitorUpdateId) -> Result_NoneChannelMonitorUpdateErrZ {
        let idBytes: [UInt8] = channel_id.write()
        let monitorBytes: [UInt8] = data.write()
        return Result_NoneChannelMonitorUpdateErrZ.ok()
    }
    
}
