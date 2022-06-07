//
//  String+Extension.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

extension String {
    var reversed: String {
        let inputStringReversed = String(self.reversed())
        let characters = Array(inputStringReversed)
        var output = String()
        
        for i in 0...characters.count - 1 {
            if i % 2 == 0 {
                if (i+1) < characters.count {
                    output.append(characters[i + 1])
                }
                output.append(characters[i])
            }
        }
        
        return output
    }
}
