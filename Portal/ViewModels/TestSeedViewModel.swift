//
//  TestSeedViewModel.swift
//  Portal
//
//  Created by Farid on 14.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class TestSeedViewModel: ObservableObject {
    @Published var testString1 = String()
    @Published var testString2 = String()
    @Published var testString3 = String()
    @Published var testString4 = String()
    
    var formIsValid = false
    var testIndices = [Int]()
    var testSolved = [String]()

    var newWalletModel: NewWalletModel
    
    private var cancalable: AnyCancellable?

    init(newWalletModel: NewWalletModel) {
        self.newWalletModel = newWalletModel
    }
    
    func setup() {
        while testIndices.count <= 3 {
            let 🎲 = Int.random(in: 1..<newWalletModel.seed.count)
            if !testIndices.contains(🎲) {
                testIndices.append(🎲)
            }
        }
                                       
        for index in testIndices {
            testSolved.append(newWalletModel.seed[index - 1])
        }
                    
        bindInputs()
    }
    
    private func bindInputs() {
        cancalable = $testString1.combineLatest($testString2, $testString3, $testString4)
            .sink(receiveValue: { output in
                self.formIsValid = self.testSolved == [output.0, output.1, output.2, output.3]
            })
    }
}
