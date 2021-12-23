//
//  UMSPluginSettings.h
//  UMSPosPay
//
//  Created by chinaums on 15/10/19.
//  Copyright © 2015年 ChinaUMS. All rights reserved.
//

#import <Foundation/Foundation.h>

//1 是走apple 0是不走
//#define SHOULD_CONTAIN_APPLE_PAY_CODES 0

/*!
 @enum
 @abstract 交易环境
 @constant UMSP_PROD 生产环境
 @constant UMSP_TEST 测试环境
 */
typedef NS_ENUM(NSInteger, UMSPluginEnvironment) {
    UMSP_PROD,
    UMSP_TEST
};

/**
 *  进入插件的方式
 */
typedef NS_ENUM(NSInteger, UMSPluginEnterType) {
    ///默认方式
    UMSPluginEnterType_Default,
    ///C扫B方式
    UMSPluginEnterType_ScanCode
};


@interface UMSPPPayPluginSettings : NSObject

+ (UMSPPPayPluginSettings *)sharedInstance;

/*!
 @property
 @abstract 设置交易环境，默认UMSP_PROD
 */
@property (nonatomic, assign) UMSPluginEnvironment umspEnviroment;

/**
 *  进入插件方式，默认UMSPluginEnterType_Default
 */
@property (nonatomic, assign) UMSPluginEnterType umspEnterType;

/*!
 @property
 @abstract 设置是否需要启动页，默认YES
 */
@property (nonatomic, assign) BOOL umspSplash;

@end
