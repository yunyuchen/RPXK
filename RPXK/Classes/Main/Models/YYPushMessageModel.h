//
//  YYPushMessageModel.h
//  RPXK
//
//  Created by yunyuchen on 2017/10/7.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYBaseModel.h"

@interface YYPushMessageModel : YYBaseModel

//"content": "您的车辆已归还成功, 感谢您使用行运兔出行电单车, 欢迎下次光临",
//"uid": 4,
//"id": 25493,
//"title": "车辆归还提醒",
//"state": 0,
//"type": 0,
//"ctime": "2017-09-20 10:35:28",
//"url": ""
@property(nonatomic, copy) NSString *content;

@property(nonatomic, assign) NSInteger uid;

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, assign) NSInteger state;

@property(nonatomic, assign) NSInteger type;

@property(nonatomic, copy) NSString *ctime;

@property(nonatomic, copy) NSString *url;

@end
