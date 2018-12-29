//
//  AppDelegate.m
//  AppDelegate
//
//  Created by Jacky Hu on 07/14/14.
//

#import "AppDelegate.h"
#import "Pingpp.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    ViewController* root = [[ViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:root];

    self.viewController = nav;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [Pingpp setDebugMode:YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#warning \
为了能正确获得结果回调请在工程 AppDelegate 文件中调用 ｀[Pingpp handleOpenURL:url withCompletion:nil]`。\
如果该方法的第二个参数传 nil，请在在 `createPayment` 方法的 `Completion` 中处理回调结果。否则，在这里处理结果。\
如果你使用了微信分享、登录等一些看起来在这里“冲突”的模块，你可以先判断 url 的 host 来决定调用哪一方的方法。\
也可以先调用 Ping++ 的方法，如果 return 的值为 false，表示这个 url 不是支付相关的，你再调用模块的方法。
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    return [Pingpp handleOpenURL:url withCompletion:nil];
}

@end
