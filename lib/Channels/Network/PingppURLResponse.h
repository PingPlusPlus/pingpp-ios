//
//  PingppURLResponse.h
//  Pingpp
//
//  Created by afon on 15/8/29.
//  Copyright (c) 2015年 PingPluspPlus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PingppURLResponse : NSObject

/**
 The last response received by the operation's connection.
 */
@property (readonly, nonatomic, strong, nullable) NSURLResponse *response;

/**
 The data received during the request.
 */
@property (readonly, nonatomic, strong, nullable) NSData *responseData;

/**
 The string representation of the response data.
 */
@property (readonly, nonatomic, copy, nullable) NSString *responseString;

/**
 The string encoding of the response.
 */
@property (readonly, nonatomic, assign) NSStringEncoding responseStringEncoding;

@end

NS_ASSUME_NONNULL_END
