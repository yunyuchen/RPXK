//
//  YYGarageViewCell.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYGarageViewCell.h"

@interface YYGarageViewCell()

@property (weak, nonatomic) IBOutlet UIView *outerView;

@end

@implementation YYGarageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.outerView.layer.cornerRadius = 5;
    self.outerView.layer.masksToBounds = YES;
    self.outerView.layer.borderColor = [UIColor colorWithHexString:@"#BFBFBF"].CGColor;
    self.outerView.layer.borderWidth = 0.5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
