//
//  YYAboutViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYAboutViewController.h"

@interface YYAboutViewController ()

@end

@implementation YYAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
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
