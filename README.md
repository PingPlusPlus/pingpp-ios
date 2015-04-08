Pingpp iOS SDK 
=================

****

## 简介

lib 文件夹下是 iOS SDK 文件，<br>
example 文件夹里面是一个简单的接入示例，该示例仅供参考。

## 版本要求

iOS SDK 要求 iOS 5.1.1 及以上版本

## 渠道选择

* 支付宝、微信支付、银联和百付宝：[下载](https://github.com/PingPlusPlus/pingpp-ios/archive/master.zip)
* 支付宝、微信支付、银联：[下载](https://github.com/PingPlusPlus/pingpp-ios/archive/alipay_wx_upmp.zip)

## 接入方法

### 安装
#### 使用 CocoaPods
1. 在 `Podfile` 添加<br>
`pod 'Pingpp', :git => 'https://github.com/PingPlusPlus/pingpp-ios.git'`<br>
如果不需要百付宝渠道，则换成<br>
`pod 'Pingpp', :git => 'https://github.com/PingPlusPlus/pingpp-ios.git', :branch => 'alipay_wx_upmp'`
2. 运行 `pod install`
3. 从现在开始使用 `.xcworkspace` 打开项目，而不是 `.xcodeproj`
4. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"，如果使用微信，填入所注册的微信应用程序 id，如果不使用微信，则自定义，允许英文字母和数字，首字母必须是英文字母，建议起名稍复杂一些，尽量避免与其他程序冲突。

#### 手动导入
1. 获取 SDK
下载 SDK, 里面包含了 lib 文件夹和 example 文件夹。lib 文件夹里面是 SDK 的文件
2. 依赖 Frameworks:
    ```
    CFNetwork.framework
    SystemConfiguration.framework
    Security.framework
    libc++.dylib
    PassKit.framework
    libz.dylib
    libstdc++.dylib
    CoreTelephony.framework
    AddressBook.framework
    AddressBookUI.framework
    AudioToolbox.framework
    CoreAudio.framework
    CoreGraphics.framework
    ImageIO.framework
    MapKit.framework
    MessageUI.framework
    MobileCoreServices.framework
    QuartzCore.framework
    ```

3. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"，如果使用微信，填入所注册的微信应用程序 id，如果不使用微信，则自定义，允许英文字母和数字，首字母必须是英文字母，建议起名稍复杂一些，尽量避免与其他程序冲突。
4. 添加 Other Linker Flags：在 Build Settings 搜索 Other Linker Flags ，添加 `-ObjC`。

**关于如何使用 SDK 请参考 [技术文档](https://pingxx.com/document) 或者 [example](https://github.com/PingPlusPlus/pingpp-ios/tree/master/example) 文件夹里的示例。**

## 注意事项

由于百度钱包 SDK 不支持 iOS 模拟器，目前带有百度钱包的 Ping++ SDK 只能运行于真机。
