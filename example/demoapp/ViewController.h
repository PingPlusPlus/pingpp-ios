//
//  ViewController.h
//  ViewController
//
//  Created by Jacky Hu on 07/14/14.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate, UITextFieldDelegate>
{
    UIAlertView* mAlert;
    UITextField *mTextField;
}

@property(nonatomic, retain)NSString *channel;
@property(nonatomic ,retain)UITextField *mTextField;

- (void)showAlertWait;
- (void)showAlertMessage:(NSString*)msg;
- (void)hideAlert;

@end
