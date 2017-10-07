//
//  YYBatteryView.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/29.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYBatteryView : UIView

@property (nonatomic,strong) UIImageView *backgroundImageView;

@property (nonatomic,strong) UIImageView *foregroundImageView;
//设置星级
-(void)setProgress:(CGFloat)progress;

@end
