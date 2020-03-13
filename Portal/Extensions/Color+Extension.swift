//
//  Color+Extension.swift
//  Portal
//
//  Created by Farid on 13.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static var lightActiveLabel: Color {
        Color(red: 101.0/255.0, green: 106.0/255.0, blue: 114.0/255.0)
    }
    static var lightInactiveLabel: Color {
        Color(red: 171.0/255.0, green: 186.0/255.0, blue: 173.0/255.0)
    }
//    static var darkActiveLabel: Color {
//        Color.white
//    }
    static var darkInactiveLabel: Color {
        Color.white.opacity(0.6)
    }
    static var assetValueLabel: Color {
        Color(red: 80.0/255.0, green: 80.0/255.0, blue: 92.0/255.0)
    }
}
