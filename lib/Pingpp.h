//
//  Pingpp.h
//  Pingpp
//
//  Created by afon on 14/11/20.
//
#ifndef Pingpp_Pingpp_h
#define Pingpp_Pingpp_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PingppErrorOption)
{
    PingppErrInvalidCharge,
    PingppErrInvalidCredential,
    PingppErrInvalidChannel,
    PingppErrWxNotInstalled,
    PingppErrWxAppNotSupported,
    PingppErrCancelled,
    PingppErrViewControllerIsNil,
    PingppErrTestmodeNotifyFailed,
    PingppErrChannelReturnFail,
    PingppErrConnectionError,
    PingppErrUnknownError
};

@interface PingppError : NSObject

@property(readonly, assign) PingppErrorOption code;

- (NSString *)getMsg;

@end


typedef void (^PingppCompletion)(NSString *result, PingppError *error);

@protocol PingppDelegate <NSObject>

- (void)paymentResult:(NSString *)result;

@end

@interface Pingpp : NSObject

/**
 *  deprecated
 */
+ (void)createPayment:(NSString *)charge viewController:(UIViewController *)viewController appURLScheme:(NSString *)scheme delegate:(id<PingppDelegate>)delegate __attribute__((deprecated));

/**
 *  支付调用接口
 *
 *  @param charge           Charge 对象(JSON 格式字符串)
 *  @param viewController   银联渠道需要
 *  @param scheme           URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)createPayment:(NSString *)charge viewController:(UIViewController*)viewController appURLScheme:(NSString *)scheme withCompletion:(PingppCompletion)completionBlock;

/**
 *  支付调用接口(支付宝/微信)
 *
 *  @param charge           Charge 对象(JSON 格式字符串)
 *  @param scheme           URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)createPayment:(NSString *)charge appURLScheme:(NSString *)scheme withCompletion:(PingppCompletion)completion;

/**
 *  deprecated
 */
+ (void)handleOpenURL:(NSURL *)url delegate:(id<PingppDelegate>)delegate  __attribute__((deprecated));

/**
 *  回调结果接口(支付宝/微信)
 *
 *  @param url              结果url
 *  @param completionBlock  支付结果回调 Block，保证跳转支付过程中，当app被kill掉时，能通过这个接口得到支付结果
 */
+ (void)handleOpenURL:(NSURL *)url withCompletion:(PingppCompletion)completion;

/**
 *  版本号
 *
 *  @return         Pingpp SDK 版本号
 */
+ (NSString *)version;

/**
 *  设置百度钱包导航条背景
 */
+ (void)setBdWalletNavBgImage:(UIImage *)image;

/**
 *  设置百度钱包返回键Normal图像
 */
+ (void)setBdWalletNavBackNormalImage:(UIImage *)image;

/**
 *  设置百度钱包Title颜色
 */
+ (void)setBdWalletNavTitleColor:(UIColor *)color;

@end
#endif