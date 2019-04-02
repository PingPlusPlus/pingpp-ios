//
//  QQWalletSDK.h
//  QQWalletSDK
//
//  Created by Eric on 17/9/1.
//  Copyright (c) 2017年 Teccent. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  QQ钱包SDK
 */
#define QQWalletURLScheme   @"mqqwallet"
#define QQWalletAppID       @"appId"
#define QQWalletBargainorId @"bargainorId"
#define QQWalletNonce       @"nonce"
#define QQWalletPubAcc      @"pubAcc"
#define QQWalletTokenId     @"tokenId"
#define QQWalletSignature   @"sig"
#define QQWalletAppVersion  @"appVersion"
#define QQWalletParams      @"params"
#define QQWalletApplication @"application"
#define QQWalletSchemeKey   @"urlScheme"

@interface QQWalletSDK : NSObject

/**
 *  错误码
 */
typedef enum{
    QQWalletErrCodeSuccess    = 0,          /**< 成功    */
    QQWalletErrCodeCommon     = -1,         /**< 普通错误类型    */
    QQWalletErrCodeUserCancel = -11001,     /**< 用户点击取消并返回    */
}QQWalletErrCode;

/**
 *  获取QQWalletSDK的单例
 */
+ (instancetype)sharedInstance;

/**
 *  调起QQ钱包进行支付，参数为从第三方APP从服务器获取的参数，透传到手机QQ内，唤起支付功能
 *  @param appId           第三方APP在QQ钱包开放平台申请的appID
 *  @param bargainorId     第三方APP在财付通后台的商户号
 *  @param tokenId         在财付通后台下单的订单号
 *  @param sig             参数按照规则签名后的字符串
 *  @param nonce           签名过程中使用的随机串
 *  @param scheme          在您的工程中的plist文件中创建用于回调的URL SCHEMA。此URL SCHEMA用于手机QQ完成功能后，传递结果信息用。请尽量保证此URL SCHEMA不会与其他冲突。
 *  @param completion      支付完成后调用的block，包含错误码和错误信息
 */
- (void)startPayWithAppId:(NSString *)appId
              bargainorId:(NSString *)bargainorId
                  tokenId:(NSString *)tokenId
                signature:(NSString *)sig
                    nonce:(NSString *)nonce
                   scheme:(NSString *)scheme
               completion:(void (^)(QQWalletErrCode errCode, NSString *errStr))completion;

/**
 *  在手机QQ完成支付后，对本APP进行回调，传递支付执行结果
 *  @param url QQ钱包跳回第三方应用时传递过来的URL
 *  @return 是否能够响应该回调
 */
- (BOOL)hanldeOpenURL:(NSURL *)url;

/**
 *  检查当前系统环境是否支持QQWallet调用
 *  @return BOOL 当前系统环境是否支持QQWallet调用
 */
+ (BOOL)isSupportQQWallet;

@end
