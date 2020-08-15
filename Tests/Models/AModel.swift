//
//  AModel.swift
//  MMCodable_Example
//
//  Created by 林洵锋 on 2020/8/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import MMCodable
import SwiftyJSON

struct AModel: MMCodable {
    var name: String = ""
    mutating func mapping(_ json: JSON) {
        name = json["aname"].stringValue
    }
}

