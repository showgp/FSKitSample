//
//  MyVolume+ReadWriteOperations.swift
//  FSExpExtension
//
//  Created by Raymond P on 9/1/24.
//

import Foundation
import FSKit

extension MyVolume: FSVolume.ReadWriteOperations {
    func read(fromFile item: FSItem, offset: UInt64, length: Int, intoBuffer buffer: NSMutableData, replyHandler reply: @escaping (Int, (any Error)?) -> Void) {

    }
    

    func writeContents(_ contents: Data, toFile item: FSItem, atOffset offset: UInt64, replyHandler reply: @escaping (Int, (any Error)?) -> Void) {

    }

//
//    func read(
//        fromFile item: FSItem,
//        offset: UInt64,
//        length: Int,
//        buffer: FSMutableFileDataBuffer,
//        replyHandler reply: @escaping (Int, (any Error)?) -> Void
//    ) {
//        NSLog("🐛 read: \(item)")
//
//        var bytesRead = 0
//
//        if let item = item as? MyItem, let data = item.data {
//            bytesRead = data.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) in
//                let length = min(buffer.capacity(), data.count)
//                buffer.withMutableBytes { dst in
//                    memcpy(dst, ptr.baseAddress, length)
//                }
//                return length
//            }
//        }
//
//        reply(bytesRead, nil)
//    }
//
//    func write(
//        toFile item: FSItem,
//        offset: UInt64,
//        buffer: Data,
//        replyHandler reply: @escaping (Int, (any Error)?) -> Void
//    ) {
//        NSLog("🐛 write: \(item) - \(offset)")
//
//        if let item = item as? MyItem {
//            NSLog("🐛 - write: \(item.name)")
//            item.data = buffer
//            item.attributes.size = UInt64(buffer.count)
//            item.attributes.allocSize = UInt64(buffer.count)
//        }
//
//        reply(buffer.count, nil)
//    }
}
