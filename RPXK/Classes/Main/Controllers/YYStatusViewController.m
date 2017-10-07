//
//  YYStatusViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYStatusViewController.h"
#import "YYBluetoothManager.h"
#import "YYBatteryView.h"

@interface YYStatusViewController ()<YYBluetoothManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet YYBatteryView *progressView;

@property (weak, nonatomic) IBOutlet UILabel *batteryLabel;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (nonatomic,assign) CGFloat lastSpeed;

@end

@implementation YYStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(((-110) / 180.0 * M_PI));
    self.arrowImageView.transform = t;

    [self.progressView setProgress:1.2];
    
    YYBluetoothManager *manager = [YYBluetoothManager sharedManager];
    manager.delegate = self;
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
    return YES;
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateWithSpeed:(CGFloat)speed andBattery:(CGFloat)battery
{
    speed = arc4random_uniform(60);
    dispatch_async(dispatch_get_main_queue(), ^{
        QMUILog(@"speed %f  battery %f",speed,battery);
        [self.progressView setProgress:battery / 10.0];
        self.batteryLabel.text = [NSString stringWithFormat:@"%.0f",battery];
        self.speedLabel.text = [NSString stringWithFormat:@"%.0f",speed];
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        if (self.lastSpeed == 0) {
        }else{
            rotationAnimation.fromValue = [NSNumber numberWithFloat: (((-110 + 110 / 30.0 * self.lastSpeed) / 180.0 * M_PI))];
        }
        self.lastSpeed = speed;

        rotationAnimation.toValue = [NSNumber numberWithFloat: (((-110 + 110 / 30.0 * speed) / 180.0 * M_PI))];
        rotationAnimation.duration = 0.6;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        [self.arrowImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
}

-(void)dealloc
{
    //[YYBluetoothManager sharedManager].delegate = nil;
}

@end
