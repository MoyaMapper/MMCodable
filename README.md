# MMCodable

<p align="center">
  <a href="https://github.com/LinXunFeng">
    <img src="https://img.shields.io/badge/author-LinXunFeng-blue.svg" alt="Author" />
  </a>
  <a href="https://travis-ci.org/MoyaMapper/MMCodable">
    <img src="https://travis-ci.org/MoyaMapper/MMCodable.svg?branch=master" alt="Build Status" />
  </a>
  <a href="https://cocoapods.org/pods/MMCodable">
    <img src="https://img.shields.io/cocoapods/v/MMCodable.svg?style=flat" alt="Version" />
  </a>
  <a href="https://github.com/Carthage/Carthage">
    <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage" />
  </a>
  <a href="https://cocoapods.org/pods/MMCodable">
    <img src="https://img.shields.io/github/license/MoyaMapper/MMCodable.svg" alt="License" />
  </a>
  <a href="https://cocoapods.org/pods/MMCodable">
    <img src="https://img.shields.io/cocoapods/p/MMCodable.svg?style=flat" alt="Platform" />
  </a>
</p>

> `MMCodable` 是从 `MoyaMapper` 里分离出来的，基于 `SwiftyJSON` 对官方 `Codable` 进行强化的协议。无须关心原 `json` 数据中的类型，最终解析出来的类型由开发者决定！

## Requirements

- iOS 8.0+  

- Swift 5.0+

## Feature

- 无视 `json` 中值的类型，`Model` 中属性声明的是什么类型，它就是什么类型

## Usage

使用方式跟 `Codable` 一致，只是多了一个 `mapping` 方法，方便进行额外的数据和类型的映射

```swift
import MMCodable
import SwiftyJSON

struct AModel: MMCodable {
    var name: String = ""
    mutating func mapping(_ json: JSON) {
        name = json["aname"].stringValue
    }
}
```

## Installation

### Cocoapods

```ruby
pod 'MMCodable'
```

### Carthage

在你的 `Cartfile` 文件中添加如下内容:

```
github "MoyaMapper/MMCodable"
```

接着运行  `carthage update --platform ios`.

## Author

- LinXunFeng
- email: [linxunfeng@yeah.net](mailto:linxunfeng@yeah.net)
- Blogs:  [LinXunFeng‘s Blog](http://linxunfeng.top/)  | [掘金](https://juejin.im/user/58f8065e61ff4b006646c72d/posts) | [简书](https://www.jianshu.com/u/31e85e7a22a2)

## License

MMCodable is available under the MIT license. See the LICENSE file for more info.
