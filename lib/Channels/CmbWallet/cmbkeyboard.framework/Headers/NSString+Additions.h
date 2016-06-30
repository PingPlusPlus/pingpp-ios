//
//  NSString+Additions.h
//  MPBBank-Vista
//
//  Created by Xuhl on 12-12-31.
//
//

#import <Foundation/Foundation.h>

//#import "NSString+Url.h"

@interface NSString (NSString_Additions)

+ (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text;

+ (NSString *)parseCardNoToStarString:(NSString *)no;

+ (NSString *)stringWithStringOrNil:(NSString *)string;

- (NSComparisonResult)versionStringCompare:(NSString *)version;
- (BOOL)isCaseInsensitiveEqualToString:(NSString *)string;

- (NSString *)stringByUnescapingHTMLEntities;
+ (NSString *)hexStringFromData:(NSData *)data;

+ (NSString *)UUIDString;

+ (BOOL)isStringEmpty:(NSString *)str;

- (BOOL)pb_containsString:(NSString *)subString;
@end

@interface NSString (Repeat)

- (NSString *)repeatTimes:(NSUInteger)times;

@end
