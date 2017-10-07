//
//  YYMessageViewCell.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "YYPushMessageModel.h"

@interface YYMessageViewCell : QMUITableViewCell

@property (nonatomic,strong) YYPushMessageModel *model;

@end
