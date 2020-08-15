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
}

public extension MMCodable {
    mutating func mapping(_ json: JSON) { }
}

