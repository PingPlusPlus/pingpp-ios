//
//  Pingpp.h
//  Pingpp
//
//  Created by Jacky Hu on 07/14/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PingppDelegate <NSObject>

-(void)paymentResult:(NSString *)result;

@end

@interface Pingpp : NSObject

+(void)createPayment:(NSString*)credential viewController:(UIViewController*)viewController appURLScheme:(NSString*)scheme delegate:(id<PingppDelegate>)delegate;

+(void)handleOpenURL:(NSURL *)url delegate:(id<PingppDelegate>)delegate;

@end
