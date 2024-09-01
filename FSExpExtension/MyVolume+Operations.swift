//
//  MyVolume+Operations.swift
//  FSExpExtension
//
//  Created by Raymond P on 9/1/24.
//

import Foundation
import FSKit

extension MyVolume: FSVolume.Operations {
    var supportedVolumeCapabilities: FSVolume.SupportedCapabilities {
        let cap = FSVolume.SupportedCapabilities.init()
        cap.supportsHardLinks = true
        cap.supportsSymbolicLinks = true
        cap.supportsPersistentObjectIDs = true
        cap.doesNotSupportVolumeSizes = true
        cap.supportsHiddenFiles = true
        cap.supports64BitObjectIDs = true
        return cap
    }
    
    var volumeStatistics: FSStatFSResult {
        let st = FSStatFSResult(fsTypeName: "MyFS")
        let sampleNum: uint64 = 1024000
        st.blockSize = sampleNum
        st.ioSize = sampleNum
        st.totalBlocks = sampleNum
        st.availableBlocks = sampleNum
        st.freeBlocks = sampleNum
        st.totalFiles = sampleNum
        st.filesystemSubType = 0
        return st
    }

    var maxLinkCount: Int32 {
        256
    }

    var maxNameLength: Int32 {
        256
    }

    var isChownRestricted: Bool {
        true
    }

    var isLongNameTruncated: Bool {
        true
    }

    var maxXattrSizeInBits: Int32 {
        8 * 1024 * 1024
    }

    var maxFileSizeInBits: Int32 {
        17
    }

    func mount(options: [String], replyHandler reply: @escaping (FSItem?, (any Error)?) -> Void) {
        NSLog("🐛 Mount: \(options)")

        reply(root, nil)
    }
    
    func unmount(replyHandler reply: @escaping () -> Void) {
        NSLog("🐛 Unmount")
        reply()
    }
    
    func synchronize(replyHandler reply: @escaping ((any Error)?) -> Void) {
        NSLog("🐛 synchronize")
        reply(nil)
    }

    func getAttributes(_ desiredAttributes: FSItemGetAttributesRequest, of item: FSItem, replyHandler reply: @escaping (FSItemAttributes?, (any Error)?) -> Void) {
        if let item = item as? MyItem {
            NSLog("🐛 getItemAttributes1: \(item.name), \(desiredAttributes)")
            reply(item.attributes, nil)
        } else {
            NSLog("🐛 getItemAttributes2: \(item), \(desiredAttributes)")
            reply(nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
        }
    }

    func setAttributes(_ newAttributes: FSItemSetAttributesRequest, on item: FSItem, replyHandler reply: @escaping (FSItemAttributes?, (any Error)?) -> Void) {
        NSLog("🐛 setItemAttributes: \(item), \(newAttributes)")
        if let item = item as? MyItem {
            mergeAttributes(item.attributes, request: newAttributes)
            reply(item.attributes, nil)
        } else {
            reply(nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
        }
    }

    func lookupItem(named name: FSFileName, inDirectory directory: FSItem, replyHandler reply: @escaping (FSItem?, FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 lookupName: \(String(describing: name.string)), \(directory)")

        guard let directory = directory as? MyItem else {
            reply(nil, nil, fs_errorForPOSIXError(POSIXError.ENOENT.rawValue))
            return
        }

        if name.string != nil, let item = directory.children[name.string!] {
            reply(item, name, nil)
        } else {
            reply(nil, nil, fs_errorForPOSIXError(POSIXError.ENOENT.rawValue))
        }
    }

    func reclaim(item: FSItem, replyHandler reply: @escaping ((any Error)?) -> Void) {
        NSLog("🐛 reclaim: \(item)")
        reply(nil)
    }

    func readSymbolicLink(_ item: FSItem, replyHandler reply: @escaping (FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 readSymbolicLink: \(item)")
        reply(nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
    }
    
    func createItem(named name: FSFileName, type: FSItemType, inDirectory directory: FSItem, attributes newAttributes: FSItemSetAttributesRequest, replyHandler reply: @escaping (FSItem?, FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 createItemNamed: \(String(describing: name.string)) - \(newAttributes.mode)")

        guard let directory = directory as? MyItem else {
            reply(nil, nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
            return
        }

        let item = MyItem(name: name.string ?? "Unknown")
        mergeAttributes(item.attributes, request: newAttributes)
        item.attributes.parentID = directory.id
        item.attributes.type = type
        directory.addItem(item)

        reply(item, name, nil)
    }

    func createSymbolicLink(named name: FSFileName, inDirectory directory: FSItem, attributes newAttributes: FSItemSetAttributesRequest, linkContents contents: FSFileName, replyHandler reply: @escaping (FSItem?, FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 createSymbolicLinkNamed: \(name)")
        reply(nil, nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
    }

    func createLink(to item: FSItem, named name: FSFileName, inDirectory directory: FSItem, replyHandler reply: @escaping (FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 createLinkof: \(name)")
        reply(nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
    }

    func remove(item: FSItem, named name: FSFileName, fromDirectory directory: FSItem, replyHandler reply: @escaping ((any Error)?) -> Void) {
        NSLog("🐛 remove: \(name)")
        if let item = item as? MyItem, let directory = directory as? MyItem {
            directory.removeItem(item)
            reply(nil)
        } else {
            reply(fs_errorForPOSIXError(POSIXError.EIO.rawValue))
        }
    }

    func rename(item: FSItem, inDirectory sourceDirectory: FSItem, named sourceName: FSFileName, toNewName destinationName: FSFileName, inDirectory destinationDirectory: FSItem, overItem: FSItem?, replyHandler reply: @escaping (FSFileName?, (any Error)?) -> Void) {
        NSLog("🐛 renameItem: \(item)")
        reply(nil, fs_errorForPOSIXError(POSIXError.EIO.rawValue))
    }

    func enumerateDirectory(_ directory: FSItem, startingAtCookie cookie: FSDirectoryCookie, verifier: FSDirectoryVerifier, providingAttributes attributes: FSItemGetAttributesRequest?, using packer: @escaping FSDirectoryEntryPacker, replyHandler reply: @escaping (FSDirectoryVerifier, (any Error)?) -> Void) {
        NSLog("🐛 enumerateDirectory: \(directory) - \(cookie) - \(String(describing: attributes)) - \(String(describing: packer))")

        guard let directory = directory as? MyItem else {
            reply(0, fs_errorForPOSIXError(POSIXError.ENOENT.rawValue))
            return
        }

        NSLog("🐛 enumerateDirectory - \(directory.name)")

        for (idx, item) in directory.children.values.enumerated() {
            let isLast = (idx == directory.children.count - 1)

            let v = packer(
                FSFileName(string: item.name),
                item.attributes.type,
                item.id,
                idx,
                attributes == nil ? item.attributes : nil,
                isLast
            )

            NSLog("🐛 V: \(v) - \(item.name) - \(item.attributes.type) - \(item.attributes.type) - isLast: \(isLast)")
        }

        reply(0, nil)
    }

    func activate(options: [String], replyHandler reply: @escaping (FSItem?, (any Error)?) -> Void) {
        NSLog("🐛 activate: \(options)")
        reply(
            root,
            nil
        )
    }

    func deactivate(options: FSDeactivateOptions = [], replyHandler reply: @escaping ((any Error)?) -> Void) {
        NSLog("🐛 deactivate: \(options)")
        reply(nil)
    }
}

private extension MyVolume {
    private func mergeAttributes(_ existing: FSItemAttributes, request: FSItemSetAttributesRequest) {
        if request.uid >= 0 {
            existing.uid = request.uid
        }

        if request.gid >= 0 {
            existing.gid = request.gid
        }

        if request.type != .unknown {
            existing.type = request.type
        }

        if request.mode >= 0 {
            existing.mode = request.mode
        }

        if request.linkCount >= 0 {
            existing.linkCount = request.linkCount
        }

        if request.flags >= 0 {
            existing.flags = request.flags
        }

        if request.size >= 0 {
            existing.size = request.size
        }

        if request.allocSize >= 0 {
            existing.allocSize = request.allocSize
        }

        if request.fileID >= 0 {
            existing.fileID = request.fileID
        }

        if request.parentID >= 0 {
            existing.parentID = request.parentID
        }

        if request.accessTime.tv_sec > 0 {
            var timespec = timespec()
            existing.accessTime = timespec
        }

        if request.changeTime.tv_sec > 0 {
            var timespec = timespec()
            existing.changeTime = timespec
        }

        if request.modifyTime.tv_sec > 0 {
            var timespec = timespec()
            existing.modifyTime = timespec
        }

        if request.addedTime.tv_sec > 0 {
            var timespec = timespec()
            existing.addedTime = timespec
        }

        if request.birthTime.tv_sec > 0 {
            var timespec = timespec()
            existing.birthTime = timespec
        }

        if request.backupTime.tv_sec > 0 {
            var timespec = timespec()
            existing.backupTime = timespec
        }
    }
}
