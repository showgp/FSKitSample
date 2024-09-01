//
//  MyVolume+OpenCloseOperations.swift
//  FSExpExtension
//
//  Created by Raymond P on 9/1/24.
//

import Foundation
import FSKit


extension MyVolume: FSVolume.OpenCloseOperations {
    func openItem(_ item: FSItem, modes mode: FSVolume.OpenModes, replyHandler reply: @escaping ((any Error)?) -> Void) {
        if let item = item as? MyItem {
            NSLog("🐛 open: \(item.name)")
        } else {
            NSLog("🐛 open: \(item)")
        }
        reply(nil)
    }

    func close(_ item: FSItem, keeping mode: FSVolume.OpenModes, replyHandler reply: @escaping ((any Error)?) -> Void) {
        if let item = item as? MyItem {
            NSLog("🐛 close: \(item.name)")
        } else {
            NSLog("🐛 close: \(item)")
        }
        reply(nil)
    }
}

