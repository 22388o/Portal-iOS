//
//  SendCoinViewModel.swift
//  Portal
//
//  Created by Farid on 28.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
//import CodeScanner

final class SendCoinViewModel: ObservableObject {
    let asset: IAsset
    
    @ObservedObject var exchangerViewModel: ExchangerViewModel
    
    @Published var receiverAddress = String()
    @Published var txFee = String()
    
    @Published var formIsValid = false
    @Published var isShowingScanner = false
    @Published var showingAlert = false
    
    @Published var selctionIndex = 1
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(asset: IAsset) {
        print("SendCoinViewModel init")

        self.asset = asset
        self.exchangerViewModel = .init(asset: asset.coin, fiat: USD)
        
        self.$receiverAddress
            .combineLatest(exchangerViewModel.$assetValue)
            .compactMap { (address, amount) -> Bool in
                address.count > 8 && Double(amount) ?? 0.0 > 0.0
            }
            .sink { [weak self] in self?.formIsValid = $0 }
            .store(in: &subscriptions)
        
        self.$selctionIndex
            .combineLatest(exchangerViewModel.$assetValue)
            .sink {  [weak self] (selectionIndex, amount) in
                switch selectionIndex {
                case 0:
                    self?.txFee = Double(amount) ?? 0 > 0 ? "0.0001 \(self?.asset.coin.code ?? "")" : ""
                case 1:
                    self?.txFee = Double(amount) ?? 0 > 0 ? "0.0003 \(self?.asset.coin.code ?? "")" : ""
                default:
                    self?.txFee = Double(amount) ?? 0 > 0 ? "0.0005 \(self?.asset.coin.code ?? "")" : ""
                }
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        print("SendCoinViewModel deinit")
    }
    
    func send()  {
        
    }
    
    func sendAll() {
        exchangerViewModel.assetValue = asset.balanceProvider.balanceString
    }
    
    func pasteFromClipboard() {
        guard let clipboard = UIPasteboard.general.string else {
            return
        }
        receiverAddress = clipboard
    }
    
    func handleScanResults(result: Result<String, Error>) {
       self.isShowingScanner = false
       switch result {
       case .success(let data):
            print("Scanned address: \(data)")
            receiverAddress = data
       case .failure(let error):
            print("Scanning failed \(error)")
       }
    }
}

