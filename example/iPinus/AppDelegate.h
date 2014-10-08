//
//  AppDelegate.h
//  AppDelegate
//
//  Created by Jacky Hu on 07/14/14.
//

#import <UIKit/UIKit.h>
#import "Pingpp.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PingppDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *viewController;

@end
