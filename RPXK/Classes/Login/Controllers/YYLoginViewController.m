//
//  YYLoginViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/25.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYLoginViewController.h"
#import "YYUserManager.h"
#import "YYFileCacheManager.h"
#import "YYBaseRequest.h"
#import "YYSendCodeRequest.h"
#import "YYLoginRequest.h"
#import "NSDictionary+dealNullValue.h"
#import "YYFileCacheManager.h"
#import <QMUIKit/QMUIKit.h>

@interface YYLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *mobileBgView;

@property (weak, nonatomic) IBOutlet UIView *passwordBgView;

@property (weak, nonatomic) IBOutlet QMUIFillButton *validateCodeButton;

//手机号码
@property (weak, nonatomic) IBOutlet QMUITextField *mobileTextField;
//短信验证码
@property (weak, nonatomic) IBOutlet QMUITextField *messageCodeTextField;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign) NSInteger duration;

@end

@implementation YYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mobileBgView.layer.cornerRadius = 25;
    self.mobileBgView.layer.masksToBounds = YES;
    
    self.passwordBgView.layer.cornerRadius = 25;
    self.passwordBgView.layer.masksToBounds = YES;
    
    self.duration = 60;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClick:(id)sender {
    if (self.mobileTextField.text.length <= 0) {
        [QMUITips showSucceed:@"请输入您的手机号码" inView:self.view hideAfterDelay:2];
        return;
    }
    if (self.messageCodeTextField.text.length <= 0) {
        [QMUITips showSucceed:@"请输入验证码" inView:self.view hideAfterDelay:2];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    YYLoginRequest *request = [[YYLoginRequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kLoginBytelAPI];
    request.tel = self.mobileTextField.text.qmui_trim;
    request.code = self.messageCodeTextField.text.qmui_trim;
    
    [QMUITips showLoading:@"登录中..." inView:self.view];
    
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            
            [QMUITips hideAllToastInView:weakSelf.view animated:YES];
            QMUILog(@"%@",response);
            //记录用户Token
            [YYUserManager saveToken:response[@"token"]];
            NSDictionary *dict = [NSDictionary nullDic:response];
            //记录用户信息
            [YYFileCacheManager saveUserData:dict forKey:kUserInfoKey];
            
            //发送登录成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            //设置ID为别名
            //[JPUSHService setAlias:[NSString stringWithFormat:@"%@",response[@"id"]] callbackSelector:nil object:nil];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            [QMUITips showError:message inView:weakSelf.view hideAfterDelay:2];
        }
    } error:^(NSError *error) {
        [QMUITips showError:@"登录失败" inView:weakSelf.view hideAfterDelay:2];
    }];
}


- (IBAction)validateButtonClick:(UIButton *)sender {
    if (self.mobileTextField.text.length <= 0) {
        [QMUITips showWithText:@"请输入您的手机号码" inView:self.view hideAfterDelay:2];
        return;
    }
    sender.userInteractionEnabled = NO;
    [sender setTitle:[NSString stringWithFormat:@"%ld S",(long)self.duration] forState:UIControlStateNormal];
    
    YYBaseRequest *request = [YYBaseRequest nh_request];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kGetTokenAPI];
    [QMUITips showLoadingInView:self.view];
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            QMUILog(@"%@",response);
            [QMUITips hideAllToastInView:weakSelf.view animated:YES];
            YYSendCodeRequest *sendCodeRequest = [[YYSendCodeRequest alloc] init];
            sendCodeRequest.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kSendCodeAPI];
            sendCodeRequest.tel = weakSelf.mobileTextField.text.qmui_trim;
            sendCodeRequest.c_token = response;
            [sendCodeRequest nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
                
                if (success) {
                    [QMUITips showSucceed:@"短信验证码发送成功，请注意查收" inView:weakSelf.view hideAfterDelay:2];
                    QMUILog(@"%@",response);
                    
                    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(changeText) userInfo:nil repeats:YES];
                    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
                    weakSelf.timer = timer;
                }else{
                    [QMUITips showError:message inView:weakSelf.view hideAfterDelay:2];
                }
                
            }];
        }
    }];
    

}


//定时器改变文字
-(void) changeText
{
    self.duration--;
    if (self.duration < 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.duration = 60;
        self.validateCodeButton.userInteractionEnabled = YES;
        self.validateCodeButton.titleLabel.alpha = 1;
        [self.validateCodeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        return;
    }
    [self.validateCodeButton setTitle:[NSString stringWithFormat:@"%ld S",(long)self.duration] forState:UIControlStateNormal];
    
    
}

@end
