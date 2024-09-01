//
//  MyFSExtension.swift
//  MyFSExtension
//
//  Created by Khaos Tian on 6/13/24.
//

import ExtensionFoundation
import Foundation
import FSKit

@main
final class MyFSExtension: UnaryFilesystemExtension {

    var filesystem: MyFS {
        NSLog("🐛 Called filesystems")

        return .shared
    }
}

final class MyFS: FSUnaryFileSystem, FSUnaryFileSystemOperations, FSManageableResourceMaintenanceOperations {

    static let shared = MyFS()

    override init() {
        super.init()

        containerState = .active
        NSLog("🐛 Meow")
    }

    func load(_ resource: FSResource, options: [String], replyHandler reply: @escaping (FSVolume?, (any Error)?) -> Void) {
        NSLog("🐛 Load: \(resource), options: \(options)")
        let volumeID = FSVolume.Identifier(uuid: UUID(uuidString: "BC74BFE1-3ADA-4489-A4F2-B432A08DD00B")!)
        let volumeName = FSFileName(string: "TestV1")
        let volume = MyVolume(volumeID: volumeID, volumeName: volumeName)

        reply(volume, nil)

    }

    func didFinishLoading() {
        NSLog("🐛 DidFinishLoading")
    }

    func checkFileSystem(parameters: [String], connection: FSMessageConnection, taskID: UUID, replyHandler: @escaping (Progress?, (any Error)?) -> Void) {
        NSLog("🐛 Check")

        let progress = Progress(totalUnitCount: 1)
        progress.completedUnitCount = 1
        replyHandler(progress, nil)

    }

    func formatFileSystem(parameters: [String], connection: FSMessageConnection, taskID: UUID, replyHandler: @escaping (Progress?, (any Error)?) -> Void) {
        NSLog("🐛 Format")

        let progress = Progress(totalUnitCount: 1)
        progress.completedUnitCount = 1
        replyHandler(progress, nil)

    }

    enum FSError: Error {
        case internalError
    }
}

extension MyFS: FSBlockDeviceOperations {
    func probeResource(_ resource: FSResource, replyHandler: @escaping (FSProbeResult?, (any Error)?) -> Void) {
        NSLog("🐛 Probe Resource: \(resource)")

        let id = FSContainerIdentifier(uuid: UUID(uuidString: "51D4A02B-AC65-4D61-95FF-EA8F939E79C8")!)

        let res = FSProbeResult(result: .usable, name: "TestVol", containerID: id)

        replyHandler(res, nil)
    }
}
