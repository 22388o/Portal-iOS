//
//  AssetItemViewModel.swift
//  Portal
//
//  Created by Farid on 20.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AssetItemViewModel: ObservableObject {
    
    //    let marketData: MarketDataRepository
    
    private let asset: IAsset
    private let queue = DispatchQueue.main
    private var cancellable: Cancellable?
    
    let code: String
    let name: String
    let icon: UIImage
        
    @Published var balance = String()
    @Published var totalValue = String()
    @Published var price = String()
    @Published var change = String()
    
    @Published var selectedTimeframe: Timeframe = .hour
    
    init(asset: IAsset) {
        print("Init \(asset.coin.code) item view model")
        self.asset = asset
        
        code = asset.coin.code
        name = asset.coin.name
        icon = asset.coin.icon
                
        updateValues()
        
        cancellable = queue.schedule(
            after: queue.now,
            interval: .seconds(5)
        ){ [weak self] in
//            print("\(self?.code ?? "Unknown") market data is updated")
            self?.updateValues()
        }
    }
    
    deinit {
        print("Deinit \(asset.coin.code) item view model")
        cancellable = nil
    }
    
    private func updateValues() {
        balance = asset.balanceProvider.balanceString
        totalValue = asset.balanceProvider.totalValueString + "\(Int.random(in: 1...8))"
        price = asset.balanceProvider.price + "\(Int.random(in: 1...8))"
        change = asset.marketChangeProvider.changeString + "\(Int.random(in: 1...8))%"
    }
}
