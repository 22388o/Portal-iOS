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
    static var darkInactiveLabel: Color {
        Color.white.opacity(0.6)
    }
    static var assetValueLabel: Color {
        Color(red: 80.0/255.0, green: 80.0/255.0, blue: 92.0/255.0)
    }
    static var gradientTop: Color {
        Color(red: 0.0/255.0, green: 92.0/255.0, blue: 142.0/255.0)
    }
    static var gradientBottom: Color {
        Color(red: 85.0/255.0, green: 148.0/255.0, blue: 174.0/255.0)
    }
    static var assetViewButton: Color {
        Color(red: 8.0/255.0, green: 137.0/255.0, blue: 206.0/255.0)
    }
    static var coinViewRouteButtonActive: Color {
        Color(red: 101.0/255.0, green: 106.0/255.0, blue: 114.0/255.0)
    }
    static var coinViewRouteButtonInactive: Color {
        Color(red: 171.0/255.0, green: 176.0/255.0, blue: 183.0/255.0)
    }
    static var txListTxType: Color {
        Color(red: 7.0/255.0, green: 123.0/255.0, blue: 184.0/255.0)
    }
    
    static var portalBackground: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gradientTop, Color.gradientBottom]), startPoint: .top, endPoint: .bottom)
            Color.black.opacity(0.58)
        }
    }
    
}
