//
//  BModel.swift
//  MMCodable_Example
//
//  Created by 林洵锋 on 2020/8/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import MMCodable
import SwiftyJSON

struct BModel: MMCodable {
    var aModels: [AModel] = []
    var cModels: [CModel] = []
    var goodJob: String = ""
    var d3: Int = 4
    
    mutating func mapping(_ json: JSON) {
        print("BModel mapping function")
    }
    
    // 定义解析策略
    func keyDecodingStrategy() -> MMJSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
    
    // 定义默认值策略
    func customDefaultValueStrategy() -> MMJSONDecoder.NotFoundKeyOrValueDecodingStrategy {
        return .customDefaultValue(MyCustomDefaultValue())
    }
}

// 定义自己的默认值
struct MyCustomDefaultValue: MMJSONDefault {
    var boolValue: Bool { return true }
    var intValue: Int { return 1 }
    var int8Value: Int8 { return 1 }
    var int16Value: Int16 { return 1 }
    var int32Value: Int32 { return 1 }
    var int64Value: Int64 { return 1 }
    var uIntValue: UInt { return 1 }
    var uInt8Value: UInt8 { return 1 }
    var uInt16Value: UInt16 { return 1 }
    var uInt32Value: UInt32 { return 1 }
    var uInt64Value: UInt64 { return 1 }
    var floatValue: Float { return 1 }
    var doubleValue: Double { return 1 }
    var stringValue: String { return "1" }
}

