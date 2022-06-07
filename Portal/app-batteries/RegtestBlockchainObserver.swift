//
// Created by Arik Sosman on 5/28/20.
// Copyright (c) 2020 Arik Sosman. All rights reserved.
//

import Foundation
import PromiseKit

struct LDKBlockInfo {
    var height: UInt
    var hash: String
    var previousHash: String?
    var rawData: Data?
    var header: Data?
}

struct ReorgPath {
    var orphanChain: LDKBlock? // 1) disconnect from tail (typically empty)
    var newChain: LDKBlock // 2) connect from head (typically just one block)
}

class LDKBlock {
    var info: LDKBlockInfo
    var previous: LDKBlock?
    var next: LDKBlock?
    
    class func hexStringToBytes(hexString: String) -> [UInt8]? {
        let hexStr = hexString.dropFirst(hexString.hasPrefix("0x") ? 2 : 0)

        guard hexStr.count % 2 == 0 else { return nil }

        var newData = [UInt8]()

        var indexIsEven = true
        for i in hexStr.indices {
            if indexIsEven {
                let byteRange = i...hexStr.index(after: i)
                guard let byte = UInt8(hexStr[byteRange], radix: 16) else { return nil }
                newData.append(byte)
            }
            indexIsEven.toggle()
        }
        return newData
    }
    
    class func bytesToHexString(bytes: [UInt8]) -> String {
        let format = "%02hhx" // "%02hhX" (uppercase)
        return bytes.map { String(format: format, $0) }.joined()
    }

    init(info: LDKBlockInfo, previous: LDKBlock?, next: LDKBlock?) {
        self.info = info
        self.previous = previous
        self.next = next
    }

    enum SequencingError: Error {
        case appendixHasPrevious
        case prependixHasNext
    }

    func insertAfter(newNext: LDKBlock) throws -> LDKBlock {
        if (newNext.previous != nil) {
            throw SequencingError.appendixHasPrevious
        }
        if let oldNext = self.next {
            newNext.next = oldNext
            oldNext.previous = newNext
        }
        newNext.previous = self
        self.next = newNext
        return newNext
    }

    func insertBefore(newPrevious: LDKBlock) throws -> LDKBlock {
        if (newPrevious.next != nil) {
            throw SequencingError.prependixHasNext
        }
        if let oldPrevious = self.previous {
            newPrevious.previous = oldPrevious
            oldPrevious.next = newPrevious
        }
        newPrevious.next = self
        self.previous = newPrevious
        return newPrevious
    }

    func earliestBlock() -> LDKBlock {
        guard let previous = self.previous else {
            return self
        }
        return previous.earliestBlock()
    }

    func latestBlock() -> LDKBlock {
        guard let next = self.next else {
            return self
        }
        return next.latestBlock()
    }

    func seekBlockHashBackwards(hash: String) -> Bool {
        if (self.info.hash == hash) {
            return true
        }
        guard let previous = self.previous else {
            return false
        }
        return previous.seekBlockHashBackwards(hash: hash)
    }

    func getOrphanChain(lastKeptHash: String, trailingChain: LDKBlock?) -> LDKBlock? {
        if (self.info.hash == lastKeptHash) {
            if let chain = trailingChain {
                chain.previous = self
            }
            return trailingChain
        }

        let chain = LDKBlock(info: self.info, previous: nil, next: trailingChain)
        trailingChain?.previous = chain // double-link it

        return self.previous!.getOrphanChain(lastKeptHash: lastKeptHash, trailingChain: chain)
    }

    func toChainString(trailingInfo: String?) -> String {
        var currentInfo = "\(self.info.height): \(self.info.hash)"
        if let trailingInfo = trailingInfo {
            currentInfo = "\(trailingInfo)\n↘️ \(currentInfo)"
        }
        if let previous = self.previous {
            return previous.toChainString(trailingInfo: currentInfo)
        }
        return currentInfo
    };

    // Insert
    func reconcile(newChain: LDKBlock) -> ReorgPath {
        if (self.next != nil) {
            return self.latestBlock().reconcile(newChain: newChain)
        }
        if (newChain.previous != nil) {
            return self.reconcile(newChain: newChain.earliestBlock())
        }
        // gotta make sure reconciliation is tip against head
        let orphanChain = self.getOrphanChain(lastKeptHash: newChain.info.previousHash!, trailingChain: nil)
        if let chain = orphanChain {
            let anchor = chain.previous!
            chain.previous = nil // cut off the orphan chain
            anchor.next = nil // cut off the anchor
            try! anchor.insertAfter(newNext: newChain)
        } else {
            try! self.insertAfter(newNext: newChain)
        }
        return ReorgPath(orphanChain: orphanChain, newChain: newChain)
    }
}
