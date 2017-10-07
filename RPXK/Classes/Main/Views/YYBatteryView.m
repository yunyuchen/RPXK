//
//  YYBatteryView.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/29.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYBatteryView.h"

@implementation YYBatteryView

-(void)createImage
{
    _backgroundImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电池电量2"]];
    _backgroundImageView.frame=CGRectMake(0, 0, 200, 7);
    _backgroundImageView.contentMode=UIViewContentModeLeft;
    _foregroundImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电池电量1"]];
    _foregroundImageView.frame=CGRectMake(0, 0, 200, 7);
    //设置内容的对齐方式
    _foregroundImageView.contentMode=UIViewContentModeLeft;
    //如果子视图超出父视图大小时被裁剪掉
    _foregroundImageView.clipsToBounds=YES;
    [self addSubview:_backgroundImageView];
    [self addSubview:_foregroundImageView];
    self.backgroundColor=[UIColor clearColor];
}
//给用xib创建这个类对象时用的方法
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self createImage];
    }
    return self;
}
-(void)setProgress:(CGFloat)progress
{
    CGRect frame=_backgroundImageView.frame;
    
    frame.size.width=frame.size.width*(progress/10);
    
    _foregroundImageView.frame=frame;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createImage];
    }
    return self;
}

@end
