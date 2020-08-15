# execute time: 2020/08/15 18:24:45
Pod::Spec.new do |s|
  s.name             = 'MMCodable'
  s.version          = '0.0.1'
  s.summary          = 'MMCodable: A enhanced Codable'

  s.description      = <<-DESC
基于苹果官方Codable的序列化工具库
                       DESC

  s.homepage         = 'https://github.com/LinXunFeng/MMCodable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinXunFeng' => 'linxunfeng@yeah.net' }
  s.source           = { :git => 'https://github.com/LinXunFeng/MMCodable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/xunfenghellolo'

  s.ios.deployment_target = '8.0'
  s.swift_version         = '5.0'

  s.source_files = 'MMCodable/Classes/**/*'

  s.dependency "SwiftyJSON"
  
end
