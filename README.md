pingpp iOS SDK 
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

关于如何使用 SDK 请参考 [技术文档](https://pingxx.com/document) 或者参考 [example](https://github.com/PingPlusPlus/pingpp-ios/tree/master/example) 文件夹里的示例。

## 注意事项

由于百度钱包 SDK 不支持 iOS 模拟器，目前带有百度钱包的 Ping++ SDK 只能运行于真机。

## 更新日志

### 2.0.3
* 更改：<br>
支持 iOS 5.1.1

### 2.0.2
* 更改：<br>
新的测试模式<br>
百度钱包 SDK 静态库文件更新

### 2.0.1(20150112)
* 更改：<br>
更换银联静态库文件

### 2.0.1
* 更改：<br>
方法 `+handleOpenURL:withCompletion:` 中 `completion` 可以传 `nil`

### 2.0.0
* 更改：<br>
支持 arm64<br>
添加新渠道：百付宝<br>
调用方法更改<br>
callback 添加返回错误信息

### 1.0.5
* 更改：<br>
更换了测试环境 URL
