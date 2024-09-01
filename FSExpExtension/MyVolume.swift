//
//  MyVolume.swift
//  FSKitExp
//
//  Created by Khaos Tian on 6/27/24.
//

import FSKit
import os

class MyVolume: FSVolume {
    let root: MyItem = {
        let item = MyItem(name: "/")
        item.attributes.parentID = 0
        item.attributes.uid = 0
        item.attributes.gid = 0
        item.attributes.linkCount = 1
        item.attributes.type = .directory
        item.attributes.mode = UInt32(S_IFDIR | 0b111_000_000)
        item.attributes.allocSize = 1
        item.attributes.size = 1
        return item
    }()


    override init(volumeID: FSVolume.Identifier, volumeName: FSFileName) {
        super.init(volumeID: volumeID, volumeName: volumeName)
    }
}
