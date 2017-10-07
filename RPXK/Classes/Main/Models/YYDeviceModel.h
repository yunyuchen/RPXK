//
//  YYDeviceModel.h
//  RPXK
//
//  Created by yunyuchen on 2017/10/7.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYBaseModel.h"

@interface YYDeviceModel : YYBaseModel

//"id": 131,
//"bleid": "RPXK-C51709190001",
//"name": "测试",
//"state": 0,
//"deviceid": 3224
@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,copy) NSString *bleid;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSInteger state;

@property (nonatomic,assign) NSInteger deviceid;

@end
