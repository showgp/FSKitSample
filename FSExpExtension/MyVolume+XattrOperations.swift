//
//  MyVolume+XattrOperations.swift
//  FSExpExtension
//
//  Created by Raymond P on 9/1/24.
//

import Foundation
import FSKit

extension MyVolume: FSVolume.XattrOperations {
    func xattr(named name: FSFileName, ofItem item: FSItem, replyHandler reply: @escaping (Data?, (any Error)?) -> Void) {

    }

    func setXattr(named name: FSFileName, toData value: Data?, onItem item: FSItem, policy: FSVolume.SetXattrPolicy, replyHandler reply: @escaping ((any Error)?) -> Void) {

    }
    
    func listXattrs(of item: FSItem, replyHandler reply: @escaping ([FSFileName]?, (any Error)?) -> Void) {

    }


//    func xattr(
//        of item: FSItem,
//        named name: FSFileName,
//        replyHandler reply: @escaping (Data?, (any Error)?) -> Void
//    ) {
//        NSLog("🐛 xattr: \(item) - \(name.string ?? "NA")")
//
//        if let item = item as? MyItem, let key = name.string {
//            reply(item.xattrs[key], nil)
//        } else {
//            reply(nil, nil)
//        }
//    }
//
//    func setXattrOf(
//        _ item: FSItem,
//        named name: FSFileName,
//        value: Data?,
//        how: FSKitXattrCreateRequirementAndFlags,
//        replyHandler reply: @escaping ((any Error)?) -> Void
//    ) {
//        NSLog("🐛 setXattrOf: \(item)")
//
//        if let item = item as? MyItem, let key = name.string {
//            item.xattrs[key] = value
//        }
//
//        reply(nil)
//    }
//
//    func listXattrs(of item: FSItem, replyHandler reply: @escaping ([String]?, (any Error)?) -> Void) {
//        NSLog("🐛 listXattrs: \(item)")
//
//        if let item = item as? MyItem {
//            reply(Array(item.xattrs.keys), nil)
//        } else {
//            reply([], nil)
//        }
//    }
}
