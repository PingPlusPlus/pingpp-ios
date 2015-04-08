//
//  Pingpp+ApplePay.h
//  Pingpp
//
//  Created by afon on 15/3/5.
//  Copyright (c) 2015 PingPlusPlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pingpp.h"

typedef void (^PingppApplePayCompletion)(NSString *result, NSString *responseBody, NSError *error);

typedef NSDictionary* (^PingppRequestBlock)(NSUInteger amount, NSString *orderNo);

@interface Pingpp (ApplePay)

+ (void)setAppleMerchantId:(NSString *)appleMerchantId;

/// The current Apple Merchant Id.
+ (NSString *)appleMerchantId;

+ (void)setMerchantName:(NSString *)merchantName;

/// The merchant name to show.
+ (NSString *)merchantName;

+ (void)setBackendChargeURLString:(NSString *)URLString;

///
+ (NSString *)backendChargeURLString;

+ (void)setCountryCode:(NSString *)countryCode andCurrencyCode:(NSString *)currencyCode;

+ (void)beginPaymentWithAmount:(NSInteger)amount
                       orderNo:(NSString *)orderNo
                viewController:(UIViewController *)viewController
              requestDataBlock:(PingppRequestBlock)block
                    completion:(PingppApplePayCompletion)completion;

+ (void)enableApplePayTestmode:(BOOL)enable;

@end
