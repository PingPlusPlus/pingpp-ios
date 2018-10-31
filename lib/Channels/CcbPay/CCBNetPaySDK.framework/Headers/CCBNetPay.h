//
//  CCBNetPay.h
//  CCBNetPaySDK
//
//  Created by chenjunqi on 2017/1/6.
//  Copyright © 2017年 chenjunqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(NSDictionary *dic);

@interface CCBNetPay : NSObject

/**
 *  创建支付单例服务
 *
 *  @return 返回单例对象
 */
+ (instancetype)defaultService;

/**
 *  获取当前版本号
 *
 *  @return 当前版本字符串
 */
- (NSString *)currentVersion;

/**
    龙支付接口 （合并支付）  能跳转APP则APP跳转支付，否则网页支付

 @param orderStr        订单信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 支付结果回调
 */
- (void)payOrder:(NSString *)orderStr
           callback:(CompletionBlock)completionBlock;

/**
 *  龙支付接口（APP支付）
 *
 *  @param orderStr       订单信息 以 key1=value1&key2=value2 拼接
 */
- (void)payAppOrder:(NSString *)orderStr
           callback:(CompletionBlock)completionBlock;

/**
 *  处理钱包或者独立快捷app支付跳回商户app携带的支付结果Url
 *
 *  @param resultUrl        支付结果url
 *  @param completionBlock  支付结果回调
 *  在application openURL方法 调用
 */
- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(CompletionBlock)completionBlock;

/**
 *  龙支付接口（网页支付） 网页界面包含微信、支付宝支付
 *
 *  @param orderStr       订单信息
 *  @param completionBlock 支付结果回调Block
 */
- (void)payUrlOrder:(NSString *)orderStr
           callback:(CompletionBlock)completionBlock;


//********************************************
// 2.0.0版本新增方法
//********************************************

/**
 微信支付接口 
 
 @param orderStr        订单信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 支付结果回调
 */
- (void)payWechatOrder:(NSString *)orderStr
        callback:(CompletionBlock)completionBlock;

/**
 支付宝支付接口
 
 @param orderStr        订单信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 支付结果回调
 */
- (void)payAliOrder:(NSString *)orderStr
              callback:(CompletionBlock)completionBlock;

/**
 银联支付接口
 
 @param orderStr        订单信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 支付结果回调
 */
- (void)payUnionOrder:(NSString *)orderStr
            callback:(CompletionBlock)completionBlock;

/**
 界面选择支付接口
 
 @param orderStr        订单信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 支付结果回调
 */
- (void)payViewOrder:(NSString *)orderStr
           callback:(CompletionBlock)completionBlock;

/**
 授权接口
 
 @param info        授权用户相关信息 以 key1=value1&key2=value2 拼接
 @param completionBlock 授权结果回调
 */
-(void)authorizeWithInfo:(NSString *)info callback:(CompletionBlock)completionBlock;

- (NSString *)getIPAddress;

@end
