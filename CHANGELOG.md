### 2.2.10
- 更改：兼用 支付宝 最新版 客户端同步返回结果
- 更改：优化 京东、招行一网通 支付完成回调

### 2.2.9
- 新增：账户余额系统(SDK 兼容 charge 与 order 对象)
- 更改：Ping++ Debug Log 信息优化
- 更改：优化百度钱包网页支付
- 更改：优化京东支付网页支付
- 更改：更新 Demo

### 2.2.8
- 更改：更新 Apple Pay SDK
- 更改：所有web渠道添加 [Pingpp ignoreResultUrl: YES] 方法
- 更改：优化 在某些情况下 会导致 [Pingpp handleOpenURL:url withCompletion:nil] 崩溃的问题
- 更改：优化 壹收款 支付成功页面
- 更改：优化 SDK 支付失败后的回调信息
- 删除：bfb渠道(百度钱包) 可以用(bfb_wap)代替

### 2.2.7
- 新增：QQ钱包 （qpay）
- 新增：京东支付 wap版（jdpay_wap）

### 2.2.6
- 新增：分期渠道 添加 processing 状态 (交易处理中)
- 更改：更新 ApplePay SDK
- 更改：易宝支付 通过webView打开
- 更改：优化 么么贷 结果回调

### 2.2.5
- 新增：招行一网通（cmb_wallet）
- 新增：百度钱包 wap版（bfb_wap）
- 更改：分期乐(fqlpay_wap) 优化支付结果页面

### 2.2.4
- 新增：添加么么贷（mmdpay_wap）
- 更改：分期渠道通过 webView 打开
- 更改：iOS 9 以下 livemode 字段兼容以下值 [true, false, 1, 0]
- 更改：更新支付宝 SDK（支持 ipv6），依赖框架（CoreTelephony.framework, CoreMotion.framework）

### 2.2.2
* 新增：  
添加分期乐 (fqlpay_wap)    
添加量化派 (qgbc_wap)

### 2.2.1
* 更改：  
更新银联 SDK 到 3.3.3 版本

### 2.2.0
* 新增：  
添加应用内快捷支付（cnp）  
添加壹收款模块

### 2.1.4
* 更改：  
修复编译 warning 问题  
修改 podspec 默认不包含 bfb

### 2.1.3
* 更改：  
更新银联 SDK 到 3.1.1 版本  
修复 CocoaPods 导入问题  
更新支付宝 SDK  
Ping++ 静态库文件支持 Bitcode

### 2.1.2
* 更改：  
更新银联 SDK 到 3.1.0 版本

### 2.1.1
* 更改：  
修正 charge 格式不正确时的回调

### 2.1.0
* 新增：  
添加 Debug 模式，可打印出 log，方便调试。开启方法：`[Pingpp setDebugMode:YES];`
* 更改：  
charge 可以用 NSDictionary 格式传入  
更新支付宝、微信（不支持 armv7s）和百度钱包 SDK  
不包含微信静态库文件也可以调用支付

### 2.0.6
* 更改：  
添加 handleOpenURL 返回值

### 2.0.5
* 更改：  
分离各渠道静态库

### 2.0.4 (20150428)
* 更改：  
分离 Apple Pay 静态库  
更新 AlipaySDK.framework

### 2.0.4
* 新增：  
支持 Apple Pay

### 2.0.3
* 更改：  
支持 iOS 5.1.1

### 2.0.2
* 更改：  
新的测试模式  
百度钱包 SDK 静态库文件更新

### 2.0.1(20150112)
* 更改：  
更换银联静态库文件

### 2.0.1
* 更改：  
方法 `+handleOpenURL:withCompletion:` 中 `completion` 可以传 `nil`

### 2.0.0
* 更改：  
支持 arm64  
添加新渠道：百付宝  
调用方法更改  
callback 添加返回错误信息

### 1.0.5
* 更改：  
更换了测试环境 URL
