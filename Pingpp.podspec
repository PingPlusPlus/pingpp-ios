Pod::Spec.new do |s|
  s.name         = 'Pingpp'
  s.version      = '2.2.5'
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
  s.platform     = :ios, '5.1.1'
  s.source       = { :git => 'https://github.com/PingPlusPlus/pingpp-ios.git', :tag => s.version }
  s.requires_arc = true
  s.default_subspec = 'Core', 'Alipay', 'UnionPay'

  s.subspec 'Core' do |core|
    core.source_files = 'lib/*.h'
    core.public_header_files = 'lib/*.h'
    core.vendored_libraries = 'lib/*.a'
    core.resource = 'lib/*.bundle'
    core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security'
    core.ios.library = 'c++', 'stdc++', 'z'
    core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
    core.dependency 'Pingpp/Network'
  end

  s.subspec 'ApplePay' do |applepay|
    applepay.ios.weak_frameworks = 'PassKit'
    applepay.source_files = 'lib/Channels/ApplePay/*.h'
    applepay.public_header_files = 'lib/Channels/ApplePay/*.h'
    applepay.vendored_libraries = 'lib/Channels/ApplePay/*.a'
    applepay.dependency 'Pingpp/Core'
    applepay.dependency 'Pingpp/Network'
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

  s.subspec 'Bfb' do |ss|
    ss.frameworks = 'CoreTelephony', 'AddressBook', 'AddressBookUI', 'AudioToolbox', 'CoreAudio', 'CoreGraphics', 'ImageIO', 'MapKit', 'MessageUI', 'MobileCoreServices', 'QuartzCore'
    ss.public_header_files = 'lib/Channels/Bfb/Dependencies/**/*.h'
    ss.source_files = 'lib/Channels/Bfb/Dependencies/**/*.h'
    ss.resource = 'lib/Channels/Bfb/*.bundle'
    ss.vendored_libraries = 'lib/Channels/Bfb/**/*.a'
    ss.dependency 'Pingpp/Core'
  end

  s.subspec 'Network' do |ss|
    ss.source_files = 'lib/Dependencies/Network/*.h'
    ss.public_header_files = 'lib/Dependencies/Network/*.h'
    ss.vendored_libraries = 'lib/Dependencies/Network/*.a'
  end

  s.subspec 'Cnp' do |ss|
    ss.frameworks = 'AudioToolbox'
    ss.source_files = 'lib/Channels/Cnp/*.h'
    ss.public_header_files = 'lib/Channels/Cnp/*.h'
    ss.vendored_libraries = 'lib/Channels/Cnp/*.a'
    ss.resource = 'lib/Channels/Cnp/*.bundle'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/Network'
    ss.xcconfig = {
      'CLANG_CXX_LIBRARY' => 'libstdc++'
    }
  end

  s.subspec 'One' do |ss|
    ss.frameworks = 'QuartzCore'
    ss.source_files = 'lib/One/*.h'
    ss.public_header_files = 'lib/One/*.h'
    ss.vendored_libraries = 'lib/One/*.a'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/Network'
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

  s.subspec 'CmbWallet' do |ss|
    ss.vendored_libraries = 'lib/Channels/CmbWallet/*.a'
    ss.ios.vendored_frameworks = 'lib/Channels/CmbWallet/cmbkeyboard.framework'
    ss.resource = 'lib/Channels/CmbWallet/SecreteKeyBoard'
    ss.dependency 'Pingpp/Core'
    ss.dependency 'Pingpp/WebView'
  end

  s.subspec 'WebView' do |ss|
    ss.vendored_libraries = 'lib/Dependencies/WebView/*.a'
    ss.dependency 'Pingpp/Core'
  end

end
