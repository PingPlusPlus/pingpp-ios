//
//  UMSPPPayUnifyPayPlugin.h
//  UMSPosPay
//
//  Created by SunXP on 17/4/25.
//  Copyright © 2017年 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

/**
 *  支付渠道
 *
 *  @param CHANNEL_WEIXIN      微信支付
 *  @param CHANNEL_ALIPAY      支付宝支付
 *  @param CHANNEL_ALIMINIPAY  支付宝小程序支付
 */
FOUNDATION_EXTERN NSString *const CHANNEL_WEIXIN;
FOUNDATION_EXTERN NSString *const CHANNEL_ALIPAY;
FOUNDATION_EXTERN NSString *const CHANNEL_ALIMINIPAY;

typedef void(^TransactionResultBlock)(NSString *resultCode,  NSString *resultInfo);

@interface UMSPPPayUnifyPayPlugin : NSObject

/**
 *  商户下单支付接口
 *
 *  @param payChannel   支付渠道
 *  @param payData       订单信息:appPayRequest对应的json字符串
 *  @param callbackBlock 交易结果回调Block
 */
+ (void)payWithPayChannel:(NSString *)payChannel payData:(NSString *)payData callbackBlock:(TransactionResultBlock)callbackBlock;

/**
 云闪付下单接口

 @param schemes url schemes
 @param payData 订单信息:appPayRequest对应的json字符串
 @param viewController 启动支付控件的viewController
 @param callbackBlock 交易结果回调Block
 */
+ (void)cloudPayWithURLSchemes:(NSString *)schemes
                       payData:(NSString *)payData
                viewController:(UIViewController *)viewController
                 callbackBlock:(TransactionResultBlock)callbackBlock;

/**
 *  微信支付配置参数
 *
 *  @param appId   商户注册的微信支付appId
 *  @param universalLink 微信开发者Universal Link
  *  @return YES：成功 NO：失败
 *  需在AppDelegate的didFinishLaunchingWithOptions方法中调用
 */
+ (BOOL)registerApp:(NSString *)appId  universalLink:(NSString *)universalLink;

/**
 *  微信支付配置参数
 *
 *  @param url   App处理的openUrl
 *  @param otherDelegate WXApiDelegate对象，用来接收微信触发的非本功能的消息。
 *  @return YES：成功 NO：失败
 *  需在AppDelegate中的方法中调用：
 *  iOS9.0之前版本：- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
 *                          - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 *  iOS9.0之后版本：- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
 */
+ (BOOL)handleOpenURL:(NSURL *)url otherDelegate:(id<WXApiDelegate>)otherDelegate;

/*! @brief 处理微信通过Universal Link启动App时传递的数据
*
* 需要在 application:continueUserActivity:restorationHandler:中调用。
* @param userActivity 微信启动第三方应用时系统API传递过来的userActivity
* @param otherDelegate  WXApiDelegate对象，用来接收微信触发的非本功能的消息。
* 需在AppDelegate中的方法中调用：
 需要在 application:continueUserActivity:restorationHandler:中调用。
* @return 成功返回YES，失败返回NO。
 */
+(BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity otherDelegate:(id<WXApiDelegate>)otherDelegate API_AVAILABLE(ios(8.0));
/**
 云闪付处理

 @param url App处理的openUrl
 @return YES：成功 NO：失败
 */
+ (BOOL)cloudPayHandleOpenURL:(NSURL *)url;

/**
 支付宝小程序处理

 @param url App处理的openUrl
 */
+ (void)aliMiniPayHandleOpenURL:(NSURL *)url;

@end
