//
//  CMBApiObject.h
//
//  Created by Mbank on 2018/5/29.
//

#import <Foundation/Foundation.h>

@interface CMBApiObject : NSObject

@end


@interface CMBRequest: NSObject

/** 支付、协议、领券等业务功能等请求参数 **/
@property (nonatomic, strong) NSString *requestData;

/** 业务功能类型，客户端透传 **/
@property (nonatomic, strong) NSString *method;

/** 可选，app没有安装时在商户APP打开H5页面，并把request参数post过去。默认为支付的h5Url。 **/
@property (nonatomic, strong) NSString *h5Url;

/** 可选，app已经安装时要跳转到的招商银行APP具体功能的url，需业务功能给出。默认为支付的CMBJumpUrl  **/
@property (nonatomic, strong) NSString *CMBJumpUrl;

/** 可选，用于控制H5场景下导航栏是否展示，默认展示  **/
@property (nonatomic, assign) BOOL navigationBarHidden;

@end



@interface CMBResponse: NSObject

/** 应答码 */
@property (nonatomic, assign) int respCode;
/** 错误提示字符串 */
@property (nonatomic, retain) NSString *respMessage;

@end
