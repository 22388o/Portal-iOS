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
            Text("Receive \(model.name)").padding()
            HStack {
                Image("first")
                Text("Icon")
            }
            Spacer()
    
            VStack {
                Image(uiImage: generateVisualCode(address: mockAddress) ?? UIImage())
                Text(mockAddress).scaledToFill()
            }
        
            Spacer()
            Spacer()
        }
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
        ReceiveCoinView()
    }
}
#endif
