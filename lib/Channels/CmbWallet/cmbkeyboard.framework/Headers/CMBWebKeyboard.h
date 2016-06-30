//
//  CMBWebKeyboard.h
//  SKeyboardTest
//
//  Created by zk on 16/2/23.
//  Copyright © 2016年 zkr. All rights reserved.
//

#ifndef CMBWebKeyboard_h
#define CMBWebKeyboard_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define cmbKeyboardWillHideNotification @"cmbKeyboardWillHideNotification"
#define cmbKeyboardDidChangeCharactersNotification @"cmbKeyboardDidChangeCharactersNotification"

typedef NS_ENUM(NSUInteger, CMBLSUICommandPresentType) {
    CMBLSUICommandPresentTypeKeyboardLike,
    CMBLSUICommandPresentTypeFullScreen,
    CMBLSUICommandPresentTypeToolBar,// navigation br or tabbar
};

@interface CMBWebKeyboard : NSObject

@property (nonatomic, strong) UIWebView *webView;

+ (CMBWebKeyboard *)shareInstance;
- (void)showKeyboardWithRequest:(NSURLRequest *)request;
- (void)hideKeyboard;
@end


#endif /* CMBWebKeyboard_h */
