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
    PingppErrUnknownCancel,
    PingppErrViewControllerIsNil,
    PingppErrTestmodeNotifyFailed,
    PingppErrChannelReturnFail,
    PingppErrConnectionError,
    PingppErrUnknownError,
    PingppErrActivation,
    PingppErrRequestTimeOut,
    PingppErrProcessing,
    PingppErrQqNotInstalled,
};

typedef NS_ENUM(NSUInteger, PingppRequestContentTypeOption) {
    PingppRequestContentTypeJSON,
    PingppRequestContentTypeForm
};

@interface PingppError : NSObject

@property(readonly, assign) PingppErrorOption code;

- (NSString *)getMsg;

@end


typedef void (^PingppCompletion)(NSString *result, PingppError *error);


@interface Pingpp : NSObject

/**
 *  支付调用接口
 *
 *  @param charge           Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param viewController   银联渠道需要
 *  @param scheme           URL Scheme，支付宝渠道回调需要
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)createPayment:(NSObject *)charge
       viewController:(UIViewController*)viewController
         appURLScheme:(NSString *)scheme
       withCompletion:(PingppCompletion)completionBlock;

/**
 *  支付调用接口(支付宝/微信)
 *
 *  @param charge           Charge 对象(JSON 格式字符串 或 NSDictionary)
 *  @param scheme           URL Scheme，支付宝渠道回调需要
 *  @param completionBlock  支付结果回调 Block
 */
+ (void)createPayment:(NSObject *)charge
         appURLScheme:(NSString *)scheme
       withCompletion:(PingppCompletion)completion;

/**
 *  回调结果接口(支付宝/微信/测试模式)
 *
 *  @param url              结果url
 *  @param completionBlock  支付结果回调 Block，保证跳转支付过程中，当 app 被 kill 掉时，能通过这个接口得到支付结果
 *
 *  @return                 当无法处理 URL 或者 URL 格式不正确时，会返回 NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url
       withCompletion:(PingppCompletion)completion;

/**
 *  回调结果接口(支付宝/微信/测试模式)
 *
 *  @param url                结果url
 *  @param sourceApplication  源应用 Bundle identifier
 *  @param completionBlock    支付结果回调 Block，保证跳转支付过程中，当 app 被 kill 掉时，能通过这个接口得到支付结果
 *
 *  @return                   当无法处理 URL 或者 URL 格式不正确时，会返回 NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
       withCompletion:(PingppCompletion)completion;
/**
 *  web渠道支付成功后点击 "返回商户" 直接关闭支付页面
 *  @enabled        是否启用
 */
+ (void)ignoreResultUrl:(BOOL)enabled;
/**
 *  版本号
 *
 *  @return         Pingpp SDK 版本号
 */
+ (NSString *)version;

/**
 *  设置 Debug 模式
 *
 *  @param enabled    是否启用
 */
+ (void)setDebugMode:(BOOL)enabled;

/**
 *  设置 App ID
 *  @param  appId  Ping++ 的应用 ID，请登录 https://dashboard.pingxx.com 查看
 */
+ (void)setAppId:(NSString *)appId;

+ (NSString *)appId;

/**
 *  设置请求的 Content-Type
 *  @param  type  可设置为 JSON 或 Form，默认为 JSON
 */
+ (void)setRequestContentType:(PingppRequestContentTypeOption)type;

+ (PingppRequestContentTypeOption)requestContentType;

/**
 *  允许 https 自签证书，当你的 chargeURL 为 https 且为自签证书时使用该方法设置
 *  @param  allowInvalidCertificates BOOL
 */
+ (void)setAllowInvalidCertificates:(BOOL)allowInvalidCertificates;

+ (BOOL)allowInvalidCertificates;

/**
 *  设置网络请求延时（使用壹收款或者应用内快捷支付时有用）
 *
 *  @param timeout  延时时间，单位：秒
 */
+ (void)setNetworkTimeout:(NSTimeInterval)timeout;


/**
 * 设置webView navigationItem 颜色
 */
+ (void)setWebViewItemColor:(UIColor *)itemColor
                buttonColor:(UIColor*)bntColor;
@end
#endif
