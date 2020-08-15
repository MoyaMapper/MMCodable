//
//  MMCodable.swift
//  MMCodable
//
//  Created by LinXunFeng on 2020/8/15.
//

import SwiftyJSON

// MARK:- Model
public protocol MMCodable : Codable {
    init()
    mutating func mapping(_ json: JSON)
    
    /// 自定义解析策略
    func keyDecodingStrategy() -> MMJSONDecoder.KeyDecodingStrategy
    
    /// 自定义默认值策略
    func customDefaultValueStrategy() -> MMJSONDecoder.NotFoundKeyOrValueDecodingStrategy
}

public extension MMCodable {
    mutating func mapping(_ json: JSON) {
        
    }
    
    func keyDecodingStrategy() -> MMJSONDecoder.KeyDecodingStrategy {
        return .useDefaultKeys
    }
    func customDefaultValueStrategy() -> MMJSONDecoder.NotFoundKeyOrValueDecodingStrategy {
        return .MMDefaultValue
    }
}

