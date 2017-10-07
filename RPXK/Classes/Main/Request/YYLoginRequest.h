//
//  YYLoginRequest.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/29.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYBaseRequest.h"

@interface YYLoginRequest : YYBaseRequest

@property (nonatomic,copy) NSString *tel;

@property (nonatomic,copy) NSString *code;

@end
