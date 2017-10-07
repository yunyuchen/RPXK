//
//  YYMainViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/25.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYMainViewController.h"
#import "YYLoginViewController.h"
#import "YYUserManager.h"
#import "WSColorImageView.h"
#import "NSNotificationCenter+Addition.h"
#import "YYBluetoothManager.h"
#import <Masonry.h>
#import <QMUIKit/QMUIKit.h>

@interface YYMainViewController ()

@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (weak, nonatomic) IBOutlet UIView *lightView;

@property (weak, nonatomic) IBOutlet QMUIButton *bluetoothButton;

@property (weak, nonatomic) IBOutlet QMUIButton *networkButton;

@property (weak, nonatomic) IBOutlet QMUIButton *findButton;

@property (weak, nonatomic) IBOutlet QMUIButton *checkButton;

@property (weak, nonatomic) IBOutlet QMUIButton *locationButton;

@property (weak, nonatomic) IBOutlet QMUIButton *seatLockButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlViewLeadingCons;

@property (weak, nonatomic) IBOutlet UIButton *lightButton;

@property (weak, nonatomic) IBOutlet UIButton *controlButton;

@property (nonatomic,strong) UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation YYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bluetoothButton.imagePosition = QMUIButtonImagePositionTop;
    self.bluetoothButton.spacingBetweenImageAndTitle = 10;
    self.networkButton.imagePosition = QMUIButtonImagePositionTop;
    self.networkButton.spacingBetweenImageAndTitle = 10;
    self.findButton.imagePosition = QMUIButtonImagePositionTop;
    self.findButton.spacingBetweenImageAndTitle = 10;
    self.checkButton.imagePosition = QMUIButtonImagePositionTop;
    self.checkButton.spacingBetweenImageAndTitle = 10;
    self.locationButton.imagePosition = QMUIButtonImagePositionTop;
    self.locationButton.spacingBetweenImageAndTitle = 10;
    self.seatLockButton.imagePosition = QMUIButtonImagePositionTop;
    self.seatLockButton.spacingBetweenImageAndTitle = 10;
    
    [self initPickerView];
    
    [NSNotificationCenter addObserver:self action:@selector(loginSuccessAction:) name:kLoginSuccessNotification];
    
    YYBluetoothManager *manager = [YYBluetoothManager sharedManager];
    [manager connectPeripheralWithStateCallback:^(BOOL connectState) {
        
    } examBLECallback:^(BOOL isPowerOn) {
        
    }];
    // Do any additional setup after loading the view.
}

-(void) loginSuccessAction:(NSNotification *)noti
{
    
}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return YES;
}


-(void) initPickerView
{
    WSColorImageView *ws = [[WSColorImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 , 48.5, kScreenWidth - 40, kScreenWidth - 40)];
    ws.centerX = kScreenWidth * 0.5;
    [self.lightView addSubview:ws];
    
    ws.currentColorBlock = ^(UIColor *color){
        
    
        
    };
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.lineView) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 3)];
        lineView.backgroundColor = [UIColor whiteColor];
        lineView.top = CGRectGetMaxY(self.controlButton.frame) + 3;
        lineView.centerX = self.controlButton.centerX;
        [self.view addSubview:lineView];
        self.lineView = lineView;
    }
    
    if (![YYUserManager isHaveLogin]) {
        YYLoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:loginViewController animated:NO completion:nil];
    }

}

- (IBAction)controlButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.controlViewLeadingCons.constant = 0;
        self.lineView.centerX = self.controlButton.centerX;
   
    }];
}

- (IBAction)lightButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.controlViewLeadingCons.constant = -kScreenWidth;
        self.lineView.centerX = self.lightButton.centerX;
    }];
}

- (IBAction)tapAction:(id)sender {
    [self performSegueWithIdentifier:@"status" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
