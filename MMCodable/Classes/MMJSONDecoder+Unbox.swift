//
//  MMJSONDecoder+unbox.swift
//  MoyaMapper
//
//  Created by LinXunFeng on 2019/3/19.
//  Copyright © 2019 LXF. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - Concrete Value Representations

extension _MMJSONDecoder {
    /// Returns the given value unboxed from a container.
    func unbox(_ value: Any, as type: Bool.Type) throws -> Bool? {
        guard !(value is NSNull) else { return nil }
        
        if let number = value as? NSNumber {
            // TODO: Add a flag to coerce non-boolean numbers into Bools?
            if number === kCFBooleanTrue as NSNumber {
                return true
            } else if number === kCFBooleanFalse as NSNumber {
                return false
            }
            
            /* FIXME: If swift-corelibs-foundation doesn't change to use NSNumber, this code path will need to be included and tested:
             } else if let bool = value as? Bool {
             return bool
             */
            
        }
        
        throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: value)
    }
    
    func unbox(_ value: Any, as type: Int.Type) throws -> Int? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let int = number.intValue
        guard NSNumber(value: int) == number else {
            return nil
        }
        
        return int
    }
    
    func unbox(_ value: Any, as type: Int8.Type) throws -> Int8? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let int8 = number.int8Value
        guard NSNumber(value: int8) == number else {
            return nil
        }
        
        return int8
    }
    
    func unbox(_ value: Any, as type: Int16.Type) throws -> Int16? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let int16 = number.int16Value
        guard NSNumber(value: int16) == number else {
            return nil
        }
        
        return int16
    }
    
    func unbox(_ value: Any, as type: Int32.Type) throws -> Int32? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let int32 = number.int32Value
        guard NSNumber(value: int32) == number else {
            return nil
        }
        
        return int32
    }
    
    func unbox(_ value: Any, as type: Int64.Type) throws -> Int64? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let int64 = number.int64Value
        guard NSNumber(value: int64) == number else {
            return nil
        }
        
        return int64
    }
    
    func unbox(_ value: Any, as type: UInt.Type) throws -> UInt? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let uint = number.uintValue
        guard NSNumber(value: uint) == number else {
            return nil
        }
        
        return uint
    }
    
    func unbox(_ value: Any, as type: UInt8.Type) throws -> UInt8? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let uint8 = number.uint8Value
        guard NSNumber(value: uint8) == number else {
            return nil
        }
        
        return uint8
    }
    
    func unbox(_ value: Any, as type: UInt16.Type) throws -> UInt16? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let uint16 = number.uint16Value
        guard NSNumber(value: uint16) == number else {
            return nil
        }
        
        return uint16
    }
    
    func unbox(_ value: Any, as type: UInt32.Type) throws -> UInt32? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let uint32 = number.uint32Value
        guard NSNumber(value: uint32) == number else {
            return nil
        }
        
        return uint32
    }
    
    func unbox(_ value: Any, as type: UInt64.Type) throws -> UInt64? {
        guard !(value is NSNull) else { return nil }
        
        guard let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse else {
            return nil
        }
        
        let uint64 = number.uint64Value
        guard NSNumber(value: uint64) == number else {
            return nil
        }
        
        return uint64
    }
    
    func unbox(_ value: Any, as type: Float.Type) throws -> Float? {
        guard !(value is NSNull) else { return nil }
        
        if let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse {
            // We are willing to return a Float by losing precision:
            // * If the original value was integral,
            //   * and the integral value was > Float.greatestFiniteMagnitude, we will fail
            //   * and the integral value was <= Float.greatestFiniteMagnitude, we are willing to lose precision past 2^24
            // * If it was a Float, you will get back the precise value
            // * If it was a Double or Decimal, you will get back the nearest approximation if it will fit
            let double = number.doubleValue
            guard abs(double) <= Double(Float.greatestFiniteMagnitude) else {
                return nil
            }
            
            return Float(double)
            
            /* FIXME: If swift-corelibs-foundation doesn't change to use NSNumber, this code path will need to be included and tested:
             } else if let double = value as? Double {
             if abs(double) <= Double(Float.max) {
             return Float(double)
             }
             
             overflow = true
             } else if let int = value as? Int {
             if let float = Float(exactly: int) {
             return float
             }
             
             overflow = true
             */
            
        } else if let string = value as? String,
            case .convertFromString(let posInfString, let negInfString, let nanString) = self.options.nonConformingFloatDecodingStrategy {
            if string == posInfString {
                return Float.infinity
            } else if string == negInfString {
                return -Float.infinity
            } else if string == nanString {
                return Float.nan
            }
        }
        
        throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: value)
    }
    
    func unbox(_ value: Any, as type: Double.Type) throws -> Double? {
        guard !(value is NSNull) else { return nil }
        
        if let number = value as? NSNumber, number !== kCFBooleanTrue, number !== kCFBooleanFalse {
            // We are always willing to return the number as a Double:
            // * If the original value was integral, it is guaranteed to fit in a Double; we are willing to lose precision past 2^53 if you encoded a UInt64 but requested a Double
            // * If it was a Float or Double, you will get back the precise value
            // * If it was Decimal, you will get back the nearest approximation
            return number.doubleValue
            
            /* FIXME: If swift-corelibs-foundation doesn't change to use NSNumber, this code path will need to be included and tested:
             } else if let double = value as? Double {
             return double
             } else if let int = value as? Int {
             if let double = Double(exactly: int) {
             return double
             }
             
             overflow = true
             */
            
        } else if let string = value as? String,
            case .convertFromString(let posInfString, let negInfString, let nanString) = self.options.nonConformingFloatDecodingStrategy {
            if string == posInfString {
                return Double.infinity
            } else if string == negInfString {
                return -Double.infinity
            } else if string == nanString {
                return Double.nan
            }
        }
        
        throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: value)
    }
    
    func unbox(_ value: Any, as type: String.Type) throws -> String? {
        guard !(value is NSNull) else { return nil }
        
        guard let string = value as? String else {
            return nil
        }
        
        return string
    }
    
    func unbox(_ value: Any, as type: Date.Type) throws -> Date? {
        guard !(value is NSNull) else { return nil }
        
        switch self.options.dateDecodingStrategy {
        case .deferredToDate:
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try Date(from: self)
            
        case .secondsSince1970:
            let double = try self.unbox(value, as: Double.self)!
            return Date(timeIntervalSince1970: double)
            
        case .millisecondsSince1970:
            let double = try self.unbox(value, as: Double.self)!
            return Date(timeIntervalSince1970: double / 1000.0)
            
        case .iso8601:
            if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
                let string = try self.unbox(value, as: String.self)!
                guard let date = _iso8601Formatter.date(from: string) else {
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Expected date string to be ISO8601-formatted."))
                }
                
                return date
            } else {
                fatalError("ISO8601DateFormatter is unavailable on this platform.")
            }
            
        case .formatted(let formatter):
            let string = try self.unbox(value, as: String.self)!
            guard let date = formatter.date(from: string) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Date string does not match format expected by formatter."))
            }
            
            return date
            
        case .custom(let closure):
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try closure(self)
        }
    }
    
    func unbox(_ value: Any, as type: Data.Type) throws -> Data? {
        guard !(value is NSNull) else { return nil }
        
        switch self.options.dataDecodingStrategy {
        case .deferredToData:
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try Data(from: self)
            
        case .base64:
            guard let string = value as? String else {
                throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: value)
            }
            
            guard let data = Data(base64Encoded: string) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath, debugDescription: "Encountered Data is not valid Base64."))
            }
            
            return data
            
        case .custom(let closure):
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try closure(self)
        }
    }
    
    func unbox(_ value: Any, as type: Decimal.Type) throws -> Decimal? {
        guard !(value is NSNull) else { return nil }
        
        // Attempt to bridge from NSDecimalNumber.
        if let decimal = value as? Decimal {
            return decimal
        } else {
            let doubleValue = try self.unbox(value, as: Double.self)!
            return Decimal(doubleValue)
        }
    }
    
    func unboxModable<T : Decodable>(_ value: Any, as type: T.Type) throws -> T? {
        guard !(value is NSNull) else { return nil }
        let TYPE = T.self as! MMCodable.Type
        let _model = TYPE.init()
        guard let dict = value as? Dictionary<String, Any> else {
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try type.init(from: self)
        }
        let json = JSON(dict)
        
        var _dict: [String: Any] = dict
        
        for case let (key, value) in Mirror(reflecting: _model).children {
            guard let key = key else { continue }
            let _json = json[key]
            var _value : Any?
            
            if _json.rawValue is NSNull {
                _dict[key] = value
                continue
            } else {
                switch value {
                case is Bool:
                    _value = _json.boolValue
                case is Int:
                    _value = _json.intValue
                case is Int8:
                    _value = _json.int8Value
                case is Int16:
                    _value = _json.int16Value
                case is Int32:
                    _value = _json.int32Value
                case is Int64:
                    _value = _json.int64Value
                case is UInt:
                    _value = _json.uIntValue
                case is UInt8:
                    _value = _json.uInt8Value
                case is UInt16:
                    _value = _json.uInt16Value
                case is UInt32:
                    _value = _json.uInt32Value
                case is UInt64:
                    _value = _json.uInt64Value
                case is Float, is CGFloat:
                    _value = _json.floatValue
                case is Double:
                    _value = _json.doubleValue
                case is String:
                    _value = _json.stringValue
                default:
                    _value = _json.rawValue
                }
            }
            if let finalVal = _value, !(finalVal is NSNull) {
                _dict[key] = finalVal
            }
        }
        self.storage.push(container: _dict)
        defer { self.storage.popContainer() }
        var model = try type.init(from: self)
        if model is MMCodable {
            var _model = model as! MMCodable
            _model.mapping(JSON(_dict))
            model = _model as! T
        }
        return model
    }
    
    func unbox<T : Decodable>(_ value: Any, as type: T.Type) throws -> T? {
        if type == Date.self || type == NSDate.self {
            return try self.unbox(value, as: Date.self) as? T
        } else if type == Data.self || type == NSData.self {
            return try self.unbox(value, as: Data.self) as? T
        } else if type == URL.self || type == NSURL.self {
            guard let urlString = try self.unbox(value, as: String.self) else {
                return nil
            }
            
            guard let url = URL(string: urlString) else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: self.codingPath,
                                                                        debugDescription: "Invalid URL string."))
            }
            
            return url as? T
        } else if type == Decimal.self || type == NSDecimalNumber.self {
            return try self.unbox(value, as: Decimal.self) as? T
        } else if type is MMCodable.Type {
            return try self.unboxModable(value, as: type)
        } else {
            self.storage.push(container: value)
            defer { self.storage.popContainer() }
            return try type.init(from: self)
        }
    }
}

