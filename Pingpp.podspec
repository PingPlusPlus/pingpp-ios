Pod::Spec.new do |s|
  s.name         = 'Pingpp'
  s.version      = '2.3.0'
  s.summary      = 'Pingplusplus iOS SDK'
  s.description  = <<-DESC
                   移动应用支付接口。
                   开发者不再需要编写冗长的代码，简单几步就可以使你的应用获得支付功能。
                   让你的移动应用接入支付像大厦接入电力一样简单，方便，和温暖。
                   2.3.0 支持支付宝钱包及其境外支付渠道。
                   DESC
  s.homepage     = 'https://pingxx.com'
  s.license      = 'COMMERCIAL'
  s.author       = { 'Afon Weng' => 'xufeng.weng@pingxx.com' }
  s.platform     = :ios, '15.0'
  s.source       = { :http => "https://sdk-assets.oss-cn-shanghai.aliyuncs.com/pingpp/#{s.version}/pingpp-ios-libs.zip" }
  s.requires_arc = true
  s.default_subspec = 'Core', 'Alipay'

  s.subspec 'Core' do |core|
    core.source_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.public_header_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.vendored_frameworks = 'lib/XCFrameworks/PingppCore.xcframework',
                               'lib/XCFrameworks/PingppNetwork.xcframework'
    core.resource = 'lib/*.bundle'
    core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security', 'CoreLocation'
    core.ios.library = 'c++', 'z'
    core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'Alipay' do |ss|
    ss.vendored_frameworks = 'lib/XCFrameworks/PingppAlipay.xcframework'
    ss.frameworks = 'CoreMotion', 'CoreTelephony'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppAlipaySDK', '~> 15.8.42.1'
  end

  s.subspec 'CBAlipay' do |ss|
    ss.dependency 'Pingpp/Alipay'
  end

end
