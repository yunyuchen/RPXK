//
//  YYMessageViewCell.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYMessageViewCell.h"


static UIEdgeInsets const kInsets = {8, 8, 8, 8};

static CGFloat const kContentMarginBotom = 10;
static CGFloat const kContentMarginLeftAndRight = 12;
static CGFloat const kTimeMarginBottom = 15;

@interface YYMessageViewCell()

@property (weak, nonatomic) IBOutlet YYMessageViewCell *outerView;

@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;

@end

@implementation YYMessageViewCell

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

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = CGSizeMake(size.width, 0);
    CGFloat contentLabelWidth = size.width - UIEdgeInsetsGetHorizontalValue(kInsets) - 2 * kContentMarginLeftAndRight;
    
    CGFloat resultHeight = UIEdgeInsetsGetVerticalValue(kInsets) + CGRectGetHeight(self.messageTitleLabel.bounds) + kContentMarginBotom + kContentMarginLeftAndRight;
    
    if (self.messageTimeLabel.text.length > 0) {
        CGSize contentSize = [self.messageTimeLabel sizeThatFits:CGSizeMake(contentLabelWidth, CGFLOAT_MAX)];
        resultHeight += (contentSize.height + kTimeMarginBottom);
    }
    
    if (self.messageContentLabel.text.length > 0) {
        CGSize contentSize = [self.messageContentLabel sizeThatFits:CGSizeMake(contentLabelWidth, CGFLOAT_MAX)];
        resultHeight += (contentSize.height + kContentMarginLeftAndRight);
    }

    resultSize.height = resultHeight;
    return resultSize;
}

@end
