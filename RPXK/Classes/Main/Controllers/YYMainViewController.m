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

@interface YYMainViewController ()<YYBluetoothManagerDelegate>

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

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;

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
    [NSNotificationCenter addObserver:self action:@selector(bluetoothDisconnect:) name:kBluetoothDisconnectNotification];
    
    YYBluetoothManager *manager = [YYBluetoothManager sharedManager];
    [manager connectPeripheralWithStateCallback:^(BOOL connectState) {
        
    } examBLECallback:^(BOOL isPowerOn) {
        
    }];
    manager.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [YYBluetoothManager sharedManager].delegate = self;
}

//登录成功的通知
-(void) loginSuccessAction:(NSNotification *)noti
{
    
}

//蓝牙断开连接的通知
-(void) bluetoothDisconnect:(NSNotification *)noti
{
    dispatch_async(dispatch_get_main_queue(), ^{
      self.bluetoothButton.selected = NO;
    });
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

//顶部控制TAB
- (IBAction)controlButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.controlViewLeadingCons.constant = 0;
        self.lineView.centerX = self.controlButton.centerX;
   
    }];
}

//顶部灯光TAB
- (IBAction)lightButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.controlViewLeadingCons.constant = -kScreenWidth;
        self.lineView.centerX = self.lightButton.centerX;
    }];
}

//进入时速和电量界面
- (IBAction)tapAction:(id)sender {
    [self performSegueWithIdentifier:@"status" sender:self];
}


//开启坐垫锁
- (IBAction)seatButtonClick:(id)sender {
    [[YYBluetoothManager sharedManager] openSeat];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - bluetoothManagerDelegate
-(void)updateWithSpeed:(CGFloat)speed andBattery:(CGFloat)battery
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //QMUILog(@"speed %f  battery %f",speed,battery);
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed];
        self.batteryLabel.text = [NSString stringWithFormat:@"%.0f",battery];
    });
   
}

-(void)shakeHandSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bluetoothButton.selected = YES;
    });
  
}
@end
