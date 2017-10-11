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

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *deviceIDLabel;

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

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

-(void)setModel:(YYDeviceModel *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.deviceIDLabel.text = model.bleid;
    self.defaultButton.selected = !model.state;
}

- (IBAction)setMainButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(YYGarageViewCell:didClickSetButton:)]) {
        [self.delegate YYGarageViewCell:self didClickSetButton:sender];
    }
}

- (IBAction)deleteButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(YYGarageViewCell:didClickDeleteButton:)]) {
        [self.delegate YYGarageViewCell:self didClickDeleteButton:sender];
    }
    
}

@end
