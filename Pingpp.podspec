Pod::Spec.new do |s|
  s.name         = 'Pingpp'
  s.version      = '2.2.12'
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
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/PingPlusPlus/pingpp-ios.git', :tag => s.version }
  s.requires_arc = true
  s.default_subspec = 'Core', 'Alipay', 'UnionPay'

  s.subspec 'Core' do |core|
    core.source_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.public_header_files = 'lib/*.h', 'lib/Dependencies/Network/*.h'
    core.vendored_libraries = 'lib/*.a', 'lib/Dependencies/Network/*.a'
    core.resource = 'lib/*.bundle'
    core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security'
    core.ios.library = 'c++', 'stdc++', 'z'
    core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'ApplePay' do|ss|
    ss.vendored_libraries = 'lib/Channels/ApplePay/*.a'
    ss.frameworks = 'Passkit'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Alipay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Alipay/*.a'
    ss.ios.vendored_frameworks = 'lib/Channels/Alipay/AlipaySDK.framework'
    ss.resource = 'lib/Channels/Alipay/AlipaySDK.bundle'
    ss.frameworks = 'CoreMotion', 'CoreTelephony'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Wx' do |ss|
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'UnionPay' do |ss|
    ss.vendored_libraries = 'lib/Channels/UnionPay/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'One' do |ss|
    ss.frameworks = 'QuartzCore'
    ss.source_files = 'lib/One/*.h'
    ss.public_header_files = 'lib/One/*.h'
    ss.vendored_libraries = 'lib/One/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Qgbc' do |ss|
    ss.vendored_libraries = 'lib/Channels/Qgbc/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'Fqlpay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Fqlpay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'Mmdpay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Mmdpay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
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
    ss.ios.vendored_frameworks = 'lib/Channels/CmbWallet/cmbkeyboard.framework'
    ss.resource = 'lib/Channels/CmbWallet/SecreteKeyBoard'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'Jdpay' do |ss|
    ss.vendored_libraries = 'lib/Channels/Jdpay/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'QQWallet' do |ss|
    ss.vendored_libraries = 'lib/Channels/QQWallet/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'WebView' do |ss|
    ss.vendored_libraries = 'lib/Dependencies/WebView/*.a'
    ss.dependency 'Pingpp/Core'
  end

end
