//
//  YYGarageViewCell.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDeviceModel.h"

@class YYGarageViewCell;
@protocol GarageViewCellDelegate<NSObject>

-(void) YYGarageViewCell:(YYGarageViewCell *)cell didClickSetButton:(UIButton *)setButton;

@end

@interface YYGarageViewCell : UITableViewCell

@property(nonatomic, strong) YYDeviceModel *model;

@property (nonatomic,weak) id<GarageViewCellDelegate> delegate;

@end
