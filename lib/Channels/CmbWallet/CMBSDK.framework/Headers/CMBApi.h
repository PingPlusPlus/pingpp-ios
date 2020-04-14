//
//  CMBApi.h
//
//  Created by Mbank on 2018/5/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMBApiObject.h"
#import "CMBWebview.h"

@protocol CMBApiDelegate <NSObject>
@optional

/*! @brief 发送一个sendReq后，收到招商银行APP的回应
 *
 * 收到一个来自招商银行APP的处理结果。调用一次sendReq后会收到onResp。
 * @param resp 具体的回应内容，是自动释放的
 */
-(void)onResp:(CMBResponse*)resp;

@end

@interface CMBApi : NSObject

/*! @brief 检查招商银行APP是否已被用户安装，涉及跳转招商银行APP的业务功能须先
 *用此接口检查是否已安装招商银行APP
 *
 * @return 招商银行APP已安装返回YES，未安装返回NO。
 */
+(BOOL)isCMBAppInstalled;

/*! @brief 跳转到AppStore的招商银行APP下载更新页面
 *
 * @return 跳转成功返回YES，失败返回NO。
 */
+(BOOL)jumpToAppStore;

/*! @brief 获取当前招商银行SDK的版本号
 *
 * @return 返回当前招商银行SDK的版本号
 */
+(NSString *)getApiVersion;

/*! @brief 发送请求到招商银行APP，支持用户没安装招商银行APP，等待招商银行APP返回onResp
 *
 * 函数调用后，会切换到招商银行APP的界面。第三方应用程序等待招商银行APP返回onResp。招商银行APP在异步处理完成后一定会调用onResp。
 * @param request 具体的发送请求，在调用函数后，请自己释放。
 * @param appid 商户在招商银行商户系统中的appid。
 * @param viewController 当前界面对象。
 * @param delegate  CMBApiDelegate对象，用来接收招商银行APP触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+(BOOL)sendRequest:(CMBRequest *)request
             appid:(NSString *)appid
    viewController:(UIViewController *)viewController
          delegate:(id<CMBApiDelegate>)delegate;

/*! @brief 获取招行浏览器控件。
 *
 * 函数调用后，会根据请求信息生成招行浏览器并打开H5页面，可通过浏览器获取响应结果。
 * 注：仅在商户需要自定义实现导航栏时调用。
 * @param request 具体的发送请求，在调用函数后，请自己释放，具体内容参考CMBRequest参数说明。
 * @param appid 商户在招商银行商户系统中的appid。
 * @param delegate 对象，用来接收请求执行回调和标题变更的消息。
 * @return 返回浏览器控件，参数非法则返回nil。
 */
+(CMBWebview *) initCMBWebview: (CMBRequest *)request
                         appid:(NSString *)appid
                   delegate:(id<CMBWebviewDelegate>)delegate;


/*! @brief 发送请求打开H5支付页面或者跳转到招商银行APP完成支付，并等待招商银行APP返回结果。
 *
 * 函数调用后，会根据是否安装招商银行APP切换到招商银行APP的界面或直接打开H5支付界面， 第三方应用程序等待招商银行APP回调errBlock或succBlock。
 * 注：普通商户请勿使用该接口
 * @param payUrl 具体的支付请求（URL+支付参数）。
 * @param appid 选传，商户在招商银行相应的业务功能商户系统中的appid，请产品经理给出。
 * @param method 选传，业务功能类型，请产品经理给出。
 * @param errBlock 支付失败后回调的block。
 * @param succBlock 支付成功后回调的block。
 */
+(void)callPay:(NSString *)payUrl
         appid:(NSString *)appid
        method:(NSString *)method
       onError:(void(^)(NSString *url))errBlock
     onSuccess:(void(^)(NSString *url))succBlock;

/*! @brief 处理招商银行APP通过URL启动商户App时传递的数据
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 招商银行APP启动第三方应用时传递过来的URL
 * @param delegate  CMBApiDelegate对象，用来接收招商银行APP触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+(BOOL)handleOpenURL:(NSURL *) url delegate:(id<CMBApiDelegate>) delegate;

@end
