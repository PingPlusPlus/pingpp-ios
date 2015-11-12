//
//  ViewController.m
//  demoapp
//
//  Created by afon on 14/12/21.
//  Copyright (c) 2014年 Pingplusplus. All rights reserved.
//

#import "ViewController.h"
#import "Pingpp.h"
#import "Util.h"

#warning 请修改此处 URL 地址
static NSString *kServerChargeURL = @"YOUR-SERVER-CHARGE-URL";

#warning 请修改 Info 里的 URL Types，添加自己的 URL Schemes，Ping++ 会自动获取第一个，你也可以手动调用接口设置，请参见 Pingpp.h 说明

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomSpace;
@property (weak, nonatomic) IBOutlet UIView *payButtonView;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountLeaderSpace;

@property (nonatomic, assign) BOOL viewsLoaded;
@property (nonatomic, assign) UITextField *currentField;
@property (nonatomic, assign) NSUInteger totalAmount;
@property (nonatomic, retain) NSArray *itemCounts;

@end

@implementation ViewController

static NSDictionary *itemPrices = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (itemPrices == nil) {
        itemPrices = @{@"item1":@"10", @"item2":@"26900", @"item3":@"29900"};
    }
    
    UITapGestureRecognizer *blankTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBlankTap:)];
    [self.view addGestureRecognizer:blankTap];
    [[self scrollView] setScrollEnabled:YES];
    
    [Pingpp setDebugMode:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (![self viewsLoaded]) {
        CGRect rect = [[self payButtonView] frame];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        
        NSString *text = @"去 结 算";
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((rect.size.width-70)/2, (rect.size.height-20)/2, 70, 20)];
        [label setText:text];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        
        [button setImage:[Util imageOfButtonGreen]  forState:UIControlStateNormal];
        [button addSubview:label];
        [button addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        [[self payButtonView] addSubview:button];
        [[self payButtonView] setBackgroundColor:[UIColor clearColor]];
        
        [self setViewsLoaded:YES];
    }
    [[self scrollView] setContentSize:CGSizeMake([[self scrollView] frame].size.width, [[[self view] viewWithTag:101] frame].size.height * 3 + 50)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [(UILabel *)[[self view] viewWithTag:401] setText:[NSString stringWithFormat:@"¥ %.02f", [itemPrices[@"item1"] floatValue]/100]];
    [(UILabel *)[[self view] viewWithTag:402] setText:[NSString stringWithFormat:@"¥ %.02f", [itemPrices[@"item2"] floatValue]/100]];
    [(UILabel *)[[self view] viewWithTag:403] setText:[NSString stringWithFormat:@"¥ %.02f", [itemPrices[@"item3"] floatValue]/100]];
    
    UITextField *field1 = (UITextField *)[[self view] viewWithTag:301];
    [field1 setDelegate:self];
    [field1 setKeyboardType:UIKeyboardTypeNumberPad];
    UITextField *field2 = (UITextField *)[[self view] viewWithTag:302];
    [field2 setDelegate:self];
    [field2 setKeyboardType:UIKeyboardTypeNumberPad];
    UITextField *field3 = (UITextField *)[[self view] viewWithTag:303];
    [field3 setDelegate:self];
    [field3 setKeyboardType:UIKeyboardTypeNumberPad];
    
    [self calcAmount];
}

- (void)handleBlankTap:(UITapGestureRecognizer *)recognizer {
    if ([self currentField]) {
        [[self currentField] resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payClick:(id)sender {
    if ([self totalAmount] == 0) {
        return;
    }
    NSString *orderNo = [ViewController rand_str:12]; // orderNo 一般在服务器生成
    NSArray *extra = @[
                       @[
                           @"商品", [self itemCounts]
                           ],
                       @[
                           @"运费", @[@"¥ 0.00"]
                           ]
                       ];
    
    [Pingpp setNetworkTimeout:5];
    [Pingpp payWithOrderNo:orderNo
                    amount:[self totalAmount]
                   display:extra
                 serverURL:kServerChargeURL
              customParams:@{@"custom_key_1":@"custom_value_1",@"custom_key_2":@"custom_value_2"}
              appURLScheme:@"pingppdemoapp" // Info.plist 中的 CFBundleURLSchemes 对应
            viewController:self
         completionHandler:^(NSString *result, PingppError *error) {
             NSLog(@">>>>>>> %@", result);
         }];
}

+ (NSString *)rand_str:(int) l {
    char pool[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    char data[l];
    for (int x=0;x<l;data[x++] = (char)(pool[arc4random_uniform(62)]));
    return [[NSString alloc] initWithBytes:data length:l encoding:NSUTF8StringEncoding];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setCurrentField:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setCurrentField:nil];
    if ([[textField text] length] == 0) {
        [textField setText:@"0"];
    }
    [self calcAmount];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *oldText = [textField text];
    if ([string length] > 0 && [oldText length] >= 2) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)calcAmount {
    UITextField *field1 = (UITextField *)[[self view] viewWithTag:301];
    UITextField *field2 = (UITextField *)[[self view] viewWithTag:302];
    UITextField *field3 = (UITextField *)[[self view] viewWithTag:303];
    NSString *count1 = [field1 text];
    NSString *count2 = [field2 text];
    NSString *count3 = [field3 text];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([count1 intValue] > 0) {
        [array addObject:[NSString stringWithFormat:@"Kaico 搪瓷水壶 x %@", count1]];
    }
    if ([count2 intValue] > 0) {
        [array addObject:[NSString stringWithFormat:@"橡胶花瓶 x %@", count2]];
    }
    if ([count3 intValue] > 0) {
        [array addObject:[NSString stringWithFormat:@"扫把和簸箕 x %@", count3]];
    }
    [self setItemCounts:array];
    
    NSUInteger amount = [itemPrices[@"item1"] intValue] * [count1 intValue]
    + [itemPrices[@"item2"] intValue] * [count2 intValue]
    + [itemPrices[@"item3"] intValue] * [count3 intValue];
    [self setTotalAmount:amount];
    NSString *amountStr = [NSString stringWithFormat:@"¥ %.02f", (CGFloat)[self totalAmount]/100];
    [[self amountLabel] setNumberOfLines:0];
    [[self amountLabel] setTextAlignment:NSTextAlignmentLeft];
    UIFont *font = [[self amountLabel] font];
    CGSize stringSize = [amountStr sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [self amountLeaderSpace].constant = stringSize.width;
    [[self amountLabel] setText:amountStr];
    [[self amountLabel] layoutIfNeeded];
}
@end
