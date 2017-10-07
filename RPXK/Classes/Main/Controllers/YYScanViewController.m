//
//  YYScanViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/29.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYScanViewController.h"
#import "StyleDIY.h"
#import "YYCheckBLERequest.h"
#import "YYAddBikeRequest.h"
#import <QMUIKit/QMUIKit.h>

@interface YYScanViewController ()<QMUITextFieldDelegate>

@property (weak, nonatomic) IBOutlet QMUIButton *flashButton;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIView *flashView;

@property (nonatomic,strong) QMUIModalPresentationViewController *modalPrentViewController;

@property(nonatomic, weak) QMUIDialogTextFieldViewController *currentTextFieldDialogViewController;

@end

@implementation YYScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.libraryType = SLT_Native;
    self.scanCodeType = SCT_QRCode;
    self.cameraInvokeMsg = @"相机启动中";
    self.qRScanView.layer.cornerRadius = 5;
    self.style = [StyleDIY recoCropRect];
    
    self.flashButton.imagePosition = QMUIButtonImagePositionTop;
    self.flashButton.spacingBetweenImageAndTitle = 10;
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied)
    {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
        }];
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" preferredStyle:QMUIAlertControllerStyleAlert];
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawTitle];
    
    [self.view bringSubviewToFront:self.flashView];
    [self.view bringSubviewToFront:self.closeButton];
    [self.view bringSubviewToFront:self.flashButton];
}

-(void) drawTitle
{
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
//    titleLabel.centerX = kScreenWidth * 0.5;
//    titleLabel.centerY = CGRectGetMinY(self.leftBottomView.frame) - 20;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.text = @"对准车牌上的二维码，即可自动扫描";
//    titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.view addSubview:titleLabel];
//    [self.view bringSubviewToFront:titleLabel];
}

- (IBAction)dismissButtonClick:(id)sender {
    [self stopScan];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flashButtonClick:(id)sender {
    [self openOrCloseFlash];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1)
    {
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        return;
    }
    
    YYCheckBLERequest *request = [[YYCheckBLERequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kCheckBleAPI];
    request.bleid = strResult;
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
            dialogViewController.title = @"请输入昵称";
            dialogViewController.textField.delegate = self;
            dialogViewController.textField.placeholder = @"昵称";
            [dialogViewController addCancelButtonWithText:@"取消" block:nil];
            [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
                [aDialogViewController hide];
                
                YYAddBikeRequest *request = [[YYAddBikeRequest alloc] init];
                request.name = weakSelf.currentTextFieldDialogViewController.textField.text;
                request.bleid = strResult;
                request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kAddBikeAPI];
                [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
                    if (success) {
                        [QMUITips showWithText:message inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:2];
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else{
                        [QMUITips showWithText:message inView:weakSelf.view hideAfterDelay:2];
                        [weakSelf reStartDevice];
                    }
                } error:^(NSError *error) {
                    
                }];
            }];
            [dialogViewController show];
            weakSelf.currentTextFieldDialogViewController = dialogViewController;
        }else{
            [QMUITips showWithText:message inView:weakSelf.view hideAfterDelay:2];
        }
    } error:^(NSError *error) {
        
    }];
}


//开关闪光灯
- (void)openOrCloseFlash
{
    [super openOrCloseFlash];
    
    if (self.isOpenFlash)
    {
        [self.flashButton setImage:[UIImage imageNamed:@"手电筒2"] forState:UIControlStateNormal];
    }
    else{
        [self.flashButton setImage:[UIImage imageNamed:@"手电筒"] forState:UIControlStateNormal];
    }
}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return YES;
}

@end
