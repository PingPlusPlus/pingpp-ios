# Pingpp iOS SDK

## 简介
lib 文件夹下是 iOS SDK 文件，  
example 文件夹里面是一个简单的接入示例，该示例仅供参考。

__当前版本，不需要微信的 SDK，可以正常调用微信支付__

## 版本要求

iOS SDK 要求 iOS 6.0 及以上版本

## 接入方法
### 安装
#### 使用 CocoaPods
1. 在 `Podfile` 添加

    ```
    pod 'Pingpp', '~> 2.2.5'
    ```

    默认会包含支付宝、微信和银联。你也可以自己选择渠道。  
    目前支持以下模块：
    - `Alipay`（支付宝移动支付）
    - `Wx`（微信 App 支付）
    - `UnionPay`（银联手机支付）
    - `Bfb`（百度钱包）
    - `ApplePay`
    - `Cnp`（应用内快捷支付）
    - `Fqlpay`（分期乐）
    - `Qgbc`（量化派）
    - `Mmdpay`（么么贷）
    - `CmbWallet`（招行一网通）
    - `BfbWap`（百度钱包 Wap 支付）            
    - `One`（壹收款）

    例如：

    ```
    pod 'Pingpp/Alipay', '~> 2.2.5'
    pod 'Pingpp/UnionPay', '~> 2.2.5'
    pod 'Pingpp/One', '~> 2.2.5'
    ```

2. 运行 `pod install`
3. 从现在开始使用 `.xcworkspace` 打开项目，而不是 `.xcodeproj`
4. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"，如果使用微信，填入所注册的微信应用程序 id，如果不使用微信，则自定义，允许英文字母和数字，首字母必须是英文字母，建议起名稍复杂一些，尽量避免与其他程序冲突。
5. 2.1.0 及以上版本，可打开 Debug 模式，打印出 log，方便调试。开启方法：`[Pingpp setDebugMode:YES];`。

#### 手动导入
1. 获取 SDK  
下载 SDK, 里面包含了 lib 文件夹和 example 文件夹。lib 文件夹里面是 SDK 的文件。
2. 依赖 Frameworks：

    必需：

    ```
    CFNetwork.framework
    SystemConfiguration.framework
    Security.framework
    QuartzCore.framework
    CoreTelephony.framework
    libc++.tbd
    libz.tbd
    libsqlite3.0.tbd
    libstdc++.tbd
    CoreTelephony.framework
    CoreMotion.framework
    ```

    百度钱包所需：

    ```
    AddressBook.framework
    AddressBookUI.framework
    AudioToolbox.framework
    CoreAudio.framework
    CoreGraphics.framework
    ImageIO.framework
    MapKit.framework
    MessageUI.framework
    MobileCoreServices.framework
    ```

    Apple Pay 所需：

    ```
    PassKit.framework
    ```
3. 如果不需要某些渠道，删除 `lib/Channels` 下的相应目录即可。
4. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"，如果使用微信，填入所注册的微信应用程序 id，如果不使用微信，则自定义，允许英文字母和数字，首字母必须是英文字母，建议起名稍复杂一些，尽量避免与其他程序冲突。
5. 添加 Other Linker Flags：在 Build Settings 搜索 Other Linker Flags ，添加 `-ObjC`。
6. 2.1.0 及以上版本，可打开 Debug 模式，打印出 log，方便调试。开启方法：`[Pingpp setDebugMode:YES];`。

### 额外配置
1. iOS 9 以上版本如果需要使用支付宝和微信渠道，需要在 `Info.plist` 添加以下代码：

    ```
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>weixin</string>
        <string>wechat</string>
        <string>alipay</string>
    </array>
    ```
2. iOS 9 限制了 http 协议的访问，如果 App 需要访问 `http://`，需要在 `Info.plist` 添加如下代码：

    ```
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    ```
3. 如果编译失败，遇到错误信息为：

    ```
    XXXXXXX does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target.
    ```
    请到 Xcode 项目的 `Build Settings` 标签页搜索 bitcode，将 `Enable Bitcode` 设置为 `NO`。
4. 如果不需要应用内快捷支付，请删除 `Channels/Cnp` 目录。否则，请把 `Build Settings` 中的 `CLANG_CXX_LIBRARY` 改成 `libstdc++`。  
5. `CmbWallet`（招行一网通） 需要把 招行一网通 提供的秘钥`CMBPublicKey` 添加到 `Info.plist`  如以下代码:

    ```
    <key>CMBPublicKey</key>          
        <string>IwxiAyJIT4tlwJSCbRRE0jZFTvYjt02/CrlutsMzd5O4B9PaVyUmIKSasdasdasdhWTyp3Bb9T7c9ujiUJOJ8y7893grwEae9yiOBoBmByVsCMTaxnc+lMr7A9ifk48Tz61WxsxnQTyYzrIVbuerQIUi3PSORwcPMRqi+XLX8qPXkNpLT9dMvjOasdasdasdUaAdPFc2YFHwl9dHf2ydQsxh1BHvaVO0OO+GtZ04ZKjxRyJW2HfghKLJijl;XTjrWSNizcdoefFKQsTdzvcPNvx7PsxuXKo9SosheeS/SHPk9sGNdwvL55yEBA8gNs0XZbkxJYjuwrwsQInC/N6QSaI0f0kyTA==</string>
    <key>LSApplicationCategoryType</key>
    ```
    
6. `CmbWallet`（招行一网通）  手动导入 : 需要把 `lib/Channels/CmbWallet`目录下的 `SecreteKeyBoard`文件夹手动添加到 工程中的 `Assets.xcassets` 
7. `CmbWallet`（招行一网通） pod 安装 : 需要把 `Pods/Pingpp/CmbWallet`目录下的 `SecreteKeyBoard`文件夹手动添加到 工程中的 `Assets.xcassets`
        
        
**关于如何使用 SDK 请参考 [开发者中心](https://www.pingxx.com/docs/index) 或者 [example](https://github.com/PingPlusPlus/pingpp-ios/tree/master/example) 文件夹里的示例。**

## 注意事项

- 由于百度钱包 SDK 不支持 iOS 模拟器，目前带有百度钱包的 Ping++ SDK 只能运行于真机。
- 如果不需要 Apple Pay，请不要导入 Apple Pay 的静态库。以免提交到 App Store 时审核不通过。
