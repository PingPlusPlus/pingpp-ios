//
//  Pingpp+One.h
//  pingpp+one
//
//  Created by Afon on 15/9/2.
//  Copyright (c) 2015年 pingplusplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pingpp.h"
#import "PingppURLResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^PingppOneCompletion)(NSString *result, PingppURLResponse * __nullable response, NSError * __nullable error);

typedef NS_OPTIONS(NSUInteger, PingppBtnOption) {
    PingppBtnAlipay = 1 << 0,
    PingppBtnWx = 1 << 1,
    PingppBtnUpacp = 1 << 2,
    PingppBtnUp = PingppBtnUpacp,
    PingppBtnBfb = 1 << 3,
    PingppBtnUpmp = 1 << 4
};

@interface Pingpp (One)

/**
 *  调用「壹收款」
 *  @param  orderNo         订单号，请注意保证唯一性
 *  @param  amount          订单金额，单位为分。例：150 表示 1.5 元。
 *  @param  params          自定义参数，请求 chargeURL 时，会放在 custom_params 字段
 *  @param  chargeURL       壹收款会向该地址发送请求，该地址需要返回 charge 的 JSON 字符串
 *  @param  appURLScheme    Info.plist 中填写的 URL Scheme，支付宝渠道和测试模式需要
 *  @param  viewController  当前的 ViewController
 *  @param  handler         回调
 */
+ (void)payWithOrderNo:(NSString *)orderNo
                amount:(NSUInteger)amount
                params:(nullable NSDictionary *)params
             chargeURL:(NSString *)url
          appURLScheme:(nullable NSString *)scheme
        viewController:(UIViewController *)viewController
     completionHandler:(PingppOneCompletion)handler;

/**
 *  设置请求 charge 的 URL（会被上述方法的 chargeURL 覆盖）
 *  @param  chargeURLString  请求 charge 的 URL
 */
+ (void)setChargeURLString:(NSString *)chargeURLString;

/**
 *  获取当前设置的 chargeURLString
 *  @return  设置的 charge 的 URL
 */
+ (NSString *)chargeURLString;

/**
 *  设置需要显示的渠道按钮（有序）
 *  @param  channels  渠道数组，与 API 的 channel 字段对应。例: @[@"wx", @"alipay", @"upacp", @"bfb"]
 */
+ (void)enableChannels:(NSArray *)channels;

/**
 *  设置需要显示的渠道按钮（请用上面的方法代替）
 *  @param  option  渠道。例: PingppBtnAlipay|PingppBtnWx|PingppBtnUpacp|PingppBtnBfb
 */
+ (void)enableBtn:(PingppBtnOption)option;

/**
 *  开启应用内快捷支付
 *  @param  enable  YES/NO，是否开启。(仅在导入了相应的静态库之后有用。)
 */
+ (void)enableCnp:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
