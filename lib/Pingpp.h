//
//  Pingpp.h
//  Pingpp
//
//  Created by afon on 14/11/20.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PingppErrorOption) {
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

typedef NS_OPTIONS(NSUInteger, PingppBtnOption) {
    PingppBtnAlipay = 1 << 0,
    PingppBtnWx = 1 << 1,
    PingppBtnUp = 1 << 2,
    PingppBtnBfb = 1 << 3
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
+ (BOOL)handleOpenURL:(NSURL *)url withCompletion:(PingppCompletion)completion;

/**
 *  版本号
 *
 *  @return         Pingpp SDK 版本号
 */
+ (NSString *)version;

/**
 *  版本号
 *
 *  @return         Pingpp 「壹收款」 版本号
 */
+ (NSString *)oneVersion;

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

/**
 *  调用「壹收款」
 *
 *  @param orderNo            唯一订单号
 *  @param amount             订单总金额
 *  @param contents           额外显示信息，格式：[["left0", ["right0", "right1"]], ["left1", ["right0"]]]
 *  @param url                接收「壹收款」请求并生成和返回 charge 的 URL
 *  @param completionHandler  支付结果回调 Block
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
               display:(NSArray *)contents
             serverURL:(NSString *)url
     completionHandler:(PingppCompletion)handler;

/**
 *  调用「壹收款」
 *
 *  @param orderNo            唯一订单号
 *  @param amount             订单总金额
 *  @param contents           额外显示信息，格式：[["left0", ["right0", "right1"]], ["left1", ["right0"]]]
 *  @param url                接收「壹收款」请求并生成和返回 charge 的 URL
 *  @param scheme             URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param completionHandler  支付结果回调 Block
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
               display:(NSArray *)contents
             serverURL:(NSString *)url
          appURLScheme:(NSString *)scheme
     completionHandler:(PingppCompletion)handler;

/**
 *  调用「壹收款」
 *
 *  @param orderNo            唯一订单号
 *  @param amount             订单总金额
 *  @param contents           额外显示信息，格式：[["left0", ["right0", "right1"]], ["left1", ["right0"]]]
 *  @param url                接收「壹收款」请求并生成和返回 charge 的 URL
 *  @param viewController     当前 viewController
 *  @param completionHandler  支付结果回调 Block
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
               display:(NSArray *)contents
             serverURL:(NSString *)url
        viewController:(UIViewController *)viewController
     completionHandler:(PingppCompletion)handler;

/**
 *  调用「壹收款」
 *
 *  @param orderNo            唯一订单号
 *  @param amount             订单总金额
 *  @param contents           额外显示信息，格式：[["left0", ["right0", "right1"]], ["left1", ["right0"]]]
 *  @param url                接收「壹收款」请求并生成和返回 charge 的 URL
 *  @param scheme             URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param viewController     当前 viewController
 *  @param completionHandler  支付结果回调 Block
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
               display:(NSArray *)contents
             serverURL:(NSString *)url
          appURLScheme:(NSString *)scheme
        viewController:(UIViewController *)viewController
     completionHandler:(PingppCompletion)handler;

/**
 *  调用「壹收款」
 *
 *  @param orderNo            唯一订单号
 *  @param amount             订单总金额
 *  @param contents           额外显示信息，格式：[["left0", ["right0", "right1"]], ["left1", ["right0"]]]
 *  @param url                接收「壹收款」请求并生成和返回 charge 的 URL
 *  @param customParams       传到 serverURL 的额外自定义参数
 *  @param scheme             URL Scheme，支付宝渠道回调需要，没有支付宝情况下可为 nil
 *  @param viewController     当前 viewController
 *  @param completionHandler  支付结果回调 Block
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
               display:(NSArray *)contents
             serverURL:(NSString *)url
          customParams:(NSDictionary *)customParams
          appURLScheme:(NSString *)scheme
        viewController:(UIViewController *)viewController
     completionHandler:(PingppCompletion)handler;

/**
 *  设置网络请求延时
 *
 *  @param timeout  延时时间，单位：秒
 */
+ (void)setNetworkTimeout:(NSTimeInterval)timeout;
/**
 *  选择需要显示的渠道按钮，默认所包含渠道全部开启
 *
 *  @param option
 *  例 [Pingpp enableBtn:PingppBtnAlipay|PingppBtnWx];
 */
+ (void)enableBtn:(PingppBtnOption)option;

/**
 *  设置 Debug 模式
 *
 *  @param enabled    是否启用
 */
+ (void)setDebugMode:(BOOL)enabled;

@end
