//
//  CMBWebview.h
//  CMBSDK
//
//  Created by peters wang on 2020/1/15.
//

#import <UIKit/UIKit.h>
#import "CMBApiObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CMBWebviewDelegate <NSObject>
@optional

/*! @brief 收到页面关闭响应
 *
 * 用户主动关闭/取消页面请求、或收到业务响应结果
 * @param resp 具体的回应内容，是自动释放的
 */
-(void)onClosed:(CMBResponse*)resp;

/*! @brief 收到页面标题变更通知
 *
 * 页面跳转时设置的标题内容
 * @param title 变更后的标题
 */
-(void)titleChanged:(NSString *)title;

@end

@interface CMBWebview : UIView

@property (nonatomic, strong) CMBResponse *response;

/*! @brief 初始化招行浏览器控件
 *
 * 注：商户请勿使用该方法初始化。
 *
 */
- (instancetype)initWithRequest:(CMBRequest *)request
                          appid:(NSString *)appid
                         payUrl:(nullable NSString *)payUrl
                       delegate:(id<CMBWebviewDelegate>)delegate;
    
@end

NS_ASSUME_NONNULL_END
