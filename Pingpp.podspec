Pod::Spec.new do |s|
  s.name         = "Pingpp"
  s.version      = "2.0.3"
  s.summary      = "Pingplusplus iOS SDK"
  s.description  = <<-DESC
                   移动应用支付接口。
                   开发者不再需要编写冗长的代码，简单几步就可以使你的应用获得支付功能。
                   让你的移动应用接入支付像大厦接入电力一样简单，方便，和温暖。
                   支持微信支付，公众账号支付，支付宝钱包，百度钱包，银联手机支付。
                   DESC
  s.homepage     = "https://pingxx.com"
  s.license      = "COMMERCIAL"
  s.author       = { "Afon Weng" => "xufeng.weng@pingxx.com" }
  s.platform     = :ios, "5.1.1"
  s.source       = { :git => "https://github.com/PingPlusPlus/pingpp-ios.git", :tag => "#{s.version}_all" }
  s.source_files = "lib/Pingpp.h", "lib/Dependencies/**/*.{h,m}"
  s.public_header_files     = "lib/Pingpp.h"
  s.private_header_files    = "lib/Dependencies/**/*.h"
  s.vendored_libraries      = "lib/**/*.a"
  s.ios.vendored_frameworks = "lib/Channels/AlipaySDK.framework"
  s.resource     = "lib/**/*.bundle"
  s.frameworks   = "CFNetwork", "SystemConfiguration", "Security", "CoreTelephony", "AddressBook", "AddressBookUI", "AudioToolbox", "CoreAudio", "CoreGraphics", "ImageIO", "MapKit", "MessageUI", "MobileCoreServices", "QuartzCore"
  s.ios.library  = "c++", "stdc++", "z"
  s.xcconfig     = { "OTHER_LDFLAGS" => "-lObjC" }
end
