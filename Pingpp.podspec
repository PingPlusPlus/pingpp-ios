Pod::Spec.new do |s|
  s.name         = 'Pingpp'
  s.version      = '2.2.35'
  s.summary      = 'Pingplusplus iOS SDK'
  s.description  = <<-DESC
                   移动应用支付接口。
                   开发者不再需要编写冗长的代码，简单几步就可以使你的应用获得支付功能。
                   让你的移动应用接入支付像大厦接入电力一样简单，方便，和温暖。
                   支持微信支付，公众账号支付，支付宝钱包，百度钱包，银联手机支付。
                   DESC
  s.homepage     = 'https://pingxx.com'
  s.license      = 'COMMERCIAL'
  s.author       = { 'Afon Weng' => 'xufeng.weng@pingxx.com' }
  s.platform     = :ios, '10.0'
  s.source       = { :http => "https://sdk-assets.oss-cn-shanghai.aliyuncs.com/pingpp/#{s.version}/pingpp-ios-libs.zip" }
  s.requires_arc = true
  s.default_subspec = 'Core', 'Alipay', 'UnionPay'
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}

  s.subspec 'Core' do |core|
    core.source_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.public_header_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.vendored_libraries = 'lib/*.a', 'lib/Dependencies/Network/*.a'
    core.resource = 'lib/*.bundle'
    core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security', 'CoreLocation'
    core.ios.library = 'c++', 'z'
    core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'ApplePay' do |ss|
    ss.vendored_libraries = 'lib/Channels/ApplePay/*.a'
    ss.frameworks = 'PassKit'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppUnionPayApplePaySDK'
  end

  s.subspec 'Alipay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Alipay/*.a'
    ss.frameworks = 'CoreMotion', 'CoreTelephony'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppAlipaySDK'
  end

  s.subspec 'CBAlipay' do |ss|
    ss.dependency 'Pingpp/Alipay'
  end

  s.subspec 'AlipayNoUTDID' do |ss|
    ss.vendored_libraries = 'lib/Channels/Alipay/*.a'
    ss.frameworks = 'CoreMotion', 'CoreTelephony'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppAlipaySDKNoUTDID'
  end

  s.subspec 'Wx' do |ss|
    ss.vendored_libraries = 'lib/Channels/Wx/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'WechatOpenSDK'
  end

  s.subspec 'UnionPay' do |ss|
    ss.vendored_libraries = 'lib/Channels/UnionPay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppUnionPaySDK'
  end

  s.subspec 'BfbWap' do |ss|
    ss.vendored_libraries = 'lib/Channels/BfbWap/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'Yeepay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Yeepay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'CmbWallet' do |ss|
    ss.vendored_libraries = 'lib/Channels/CmbWallet/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppCMBSDK'
  end

  s.subspec 'Jdpay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Jdpay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'QQWallet' do |ss|
    ss.vendored_libraries = 'lib/Channels/QQWallet/*.a'
    ss.public_header_files = 'lib/Channels/QQWallet/QQWalletSDK/*.h'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'WebView' do |ss|
    ss.vendored_libraries = 'lib/Dependencies/WebView/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'CcbPay' do |ss|
    ss.vendored_libraries = 'lib/Channels/CcbPay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppCcbPaySDK', '~> 2.4.2'
  end

  s.subspec 'Agreement' do |ss|
    ss.vendored_libraries = 'lib/Dependencies/Agreement/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Cmpay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Cmpay/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Lakala' do |ss|
    ss.vendored_libraries = 'lib/Channels/Lakala/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppLakalaSDK', '~> 2.0.1'
  end

  s.subspec 'Chinaums' do |ss|
    ss.vendored_libraries = 'lib/Channels/Chinaums/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'PingppChinaUmsSDK'
  end

end
