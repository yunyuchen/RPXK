//
//  YYECallViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYECallViewController.h"
#import "UILabel+UILabel_ChangeLineSpaceAndWordSpace_h.h"

@interface YYECallViewController ()

@property (weak, nonatomic) IBOutlet QMUILabel *titleLabel;

@end

@implementation YYECallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"紧急呼叫";
    [UILabel changeLineSpaceForLabel:self.titleLabel WithSpace:8];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return NO;
}

@end
