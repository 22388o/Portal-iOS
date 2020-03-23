//
//  ReceiveCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct ReceiveCoinView: View {
    let model: WalletItemViewModel
    let mockAddress = "1HqwV7F9hpUpJXubLFomcrNMUqPLzeTVNd"
    
    init(viewModel: WalletItemViewModel = CoinMock()) {
        self.model = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            VStack {
                Image(uiImage: model.icon)
                    .resizable()
                    .frame(width: 80, height: 80)
                Text("Receive \(model.name)")
                    .font(Font.mainFont(size: 23))
                    .foregroundColor(Color.lightActiveLabel)
            }    
            VStack {
                Image(uiImage: generateVisualCode(address: mockAddress) ?? UIImage())
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)

                VStack(alignment: .center, spacing: 10) {
                    Text("Your \(model.symbol) address")
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    Text(mockAddress)
                        .scaledToFill()
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel)
                    Spacer()
                }
                .padding()
                
                Button("Share") {}
                    .modifier(PButtonStyle())
                    .padding()
            }
            .frame(maxHeight: .infinity)
            .padding()
        }
        .padding()
    }
    
    private func generateVisualCode(address: String) -> UIImage? {
        let parameters: [String : Any] = [
            "inputMessage": address.data(using: .utf8)!,
            "inputCorrectionLevel": "L"
        ]
        let filter = CIFilter(name: "CIQRCodeGenerator", parameters: parameters)
        
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 6, y: 6))
        guard let cgImage = CIContext().createCGImage(scaledImage, from: scaledImage.extent) else {
            return nil
        }
        
//        let size = CGSize(width: 96, height: 96)
        
        return UIImage(cgImage: cgImage)
    }
}

#if DEBUG
struct ReceiveCoinView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveCoinView(viewModel: BTC())
    }
}
#endif
