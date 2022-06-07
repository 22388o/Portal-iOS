//
//  Data+Extension.swift
//  Portal
//
//  Created by Farid on 24.06.2021.
//

import Foundation

extension Data {
    var toStringArray: [String]? {
      return (try? JSONSerialization.jsonObject(with: self, options: [])) as? [String]
    }
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}
