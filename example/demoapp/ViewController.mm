//
//  ViewController.m
//  ViewController
//
//  Created by Jacky Hu on 07/14/14.
//

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "Pingpp.h"

#define KBtn_width        200
#define KBtn_height       40
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          20

#define kWaiting          @"正在获取支付凭据,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"

#define kPlaceHolder      @"支付金额"
#define kMaxAmount        9999999

#define kUrlScheme      @"YOUR-APP-URL-SCHEME"
#define kUrl            @"YOUR-URL"

@interface ViewController ()

@end

@implementation ViewController
@synthesize channel;
@synthesize mTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect viewRect = self.view.frame;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:viewRect];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    UIImage *headerImg = [UIImage imageNamed:@"home.png"];
    CGFloat imgViewWith = windowRect.size.width * 0.9;
    CGFloat imgViewHeight = headerImg.size.height * imgViewWith / headerImg.size.width;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:headerImg];
    [imgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    CGFloat imgx = windowRect.size.width/2-imgViewWith/2;
    [imgView setFrame:CGRectMake(imgx, KYOffSet, imgViewWith, imgViewHeight)];
    [scrollView addSubview:imgView];
    
    mTextField = [[UITextField alloc]initWithFrame:CGRectMake(imgx, KYOffSet+imgViewHeight+40, imgViewWith-40, 40)];
    mTextField.borderStyle = UITextBorderStyleRoundedRect;
    mTextField.backgroundColor = [UIColor whiteColor];
    mTextField.placeholder = kPlaceHolder;
    mTextField.keyboardType = UIKeyboardTypeNumberPad;
    mTextField.returnKeyType =UIReturnKeyDone;
    mTextField.delegate = self;
    [mTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [scrollView addSubview:mTextField];
    
    UIButton* doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneButton setTitle:@"OK" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setFrame:CGRectMake(imgx+imgViewWith-35, KYOffSet+imgViewHeight+40, 40, 40)];
    [doneButton.layer setMasksToBounds:YES];
    [doneButton.layer setCornerRadius:8.0];
    [doneButton.layer setBorderWidth:1.0];
    [doneButton.layer setBorderColor:[UIColor grayColor].CGColor];
    [scrollView addSubview:doneButton];
    
    UIButton* wxButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [wxButton setTitle:@"微信" forState:UIControlStateNormal];
    [wxButton addTarget:self action:@selector(normalPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [wxButton setFrame:CGRectMake(imgx, KYOffSet+imgViewHeight+90, imgViewWith, KBtn_height)];
    [wxButton.layer setMasksToBounds:YES];
    [wxButton.layer setCornerRadius:8.0];
    [wxButton.layer setBorderWidth:1.0];
    [wxButton.layer setBorderColor:[UIColor grayColor].CGColor];
    wxButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [wxButton setTag:1];
    [scrollView addSubview:wxButton];
    
    UIButton* alipayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [alipayButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [alipayButton addTarget:self action:@selector(normalPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [alipayButton setFrame:CGRectMake(imgx, KYOffSet+imgViewHeight+140, imgViewWith, KBtn_height)];
    [alipayButton.layer setMasksToBounds:YES];
    [alipayButton.layer setCornerRadius:8.0];
    [alipayButton.layer setBorderWidth:1.0];
    [alipayButton.layer setBorderColor:[UIColor grayColor].CGColor];
    alipayButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [alipayButton setTag:2];
    [scrollView addSubview:alipayButton];
    
    UIButton* upmpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [upmpButton setTitle:@"银联" forState:UIControlStateNormal];
    [upmpButton addTarget:self action:@selector(normalPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [upmpButton setFrame:CGRectMake(imgx, KYOffSet+imgViewHeight+190, imgViewWith, KBtn_height)];
    [upmpButton.layer setMasksToBounds:YES];
    [upmpButton.layer setCornerRadius:8.0];
    [upmpButton.layer setBorderWidth:1.0];
    [upmpButton.layer setBorderColor:[UIColor grayColor].CGColor];
    upmpButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [upmpButton setTag:3];
    [scrollView addSubview:upmpButton];
    
    [scrollView setContentSize:CGSizeMake(viewRect.size.width, KYOffSet+imgViewHeight+210+KBtn_height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
}

- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}

- (void)normalPayAction:(id)sender
{
    NSInteger tag = ((UIButton*)sender).tag;
    if (tag == 1) {
        self.channel = @"wx";
        [self normalPayAction:nil];
    } else if (tag == 2) {
        self.channel = @"alipay";
    } else if (tag == 3) {
        self.channel = @"upacp";
    } else if (tag == 4) {
        self.channel = @"bfb";
    } else {
        return;
    }
    
    [mTextField resignFirstResponder];
    long long amount = [[self.mTextField.text stringByReplacingOccurrencesOfString:@"." withString:@""] longLongValue];
    if (amount == 0) {
        return;
    }
    NSString *amountStr = [NSString stringWithFormat:@"%lld", amount];
    NSURL* url = [NSURL URLWithString:kUrl];
    NSMutableURLRequest * postRequest=[NSMutableURLRequest requestWithURL:url];

    NSDictionary* dict = @{
        @"channel" : self.channel,
        @"amount"  : amountStr
    };
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *bodyData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    ViewController * __weak weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self showAlertWait];
    [NSURLConnection sendAsynchronousRequest:postRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        [weakSelf hideAlert];
        if (httpResponse.statusCode != 200) {
            [weakSelf showAlertMessage:kErrorNet];
            return;
        }
        if (connectionError != nil) {
            NSLog(@"error = %@", connectionError);
            [weakSelf showAlertMessage:kErrorNet];
            return;
        }
        NSString* charge = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"charge = %@", charge);
        dispatch_async(dispatch_get_main_queue(), ^{
            [Pingpp createPayment:charge viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                NSLog(@"completion block: %@", result);
                if (error == nil) {
                    NSLog(@"PingppError is nil");
                } else {
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                }
                [weakSelf showAlertMessage:result];
            }];
        });
    }];
}

- (void)okButtonAction:(id)sender
{
    [mTextField resignFirstResponder];
}

- (void) textFieldDidChange:(UITextField *) textField
{
    NSString *text = textField.text;
    NSUInteger index = [text rangeOfString:@"."].location;
    if (index != NSNotFound) {
        double amount = [[text stringByReplacingOccurrencesOfString:@"." withString:@""] doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, kMaxAmount)/100];
    } else {
        double amount = [text doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, kMaxAmount)/100];
    }
    textField.text = text;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    if (self.view.frame.size.height > 480) {
        return;
    }
    int offset = frame.origin.y + 45 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

@end
