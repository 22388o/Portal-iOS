//
//  MyBroadcasterInterface.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/17/21.
//

import Foundation
import Alamofire

class RegtestBroadcasterInterface: BroadcasterInterface {
    private static let url = "https://blockstream.info/testnet/api/tx"
    
    override func broadcast_transaction(tx: [UInt8]) {
        print("TX TO BROADCAST: \(Data(tx).hexEncodedString())")
        
        var request = try! URLRequest(url: RegtestBroadcasterInterface.url, method: .post, headers: ["Content-Type": "text/plain"])
        request.httpBody = Data(tx).hexEncodedString().data(using: .utf8)
        
        AF.request(request).responseString { response in
            switch (response.result) {
            case .success(let txId):
                print("txID: \(txId)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension Data {
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map {
            String(format: format, $0)
        }.joined()
    }
    
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
}
