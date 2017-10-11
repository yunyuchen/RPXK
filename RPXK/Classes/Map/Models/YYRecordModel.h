//
//  YYRecordModel.h
//  RPXK
//
//  Created by yunyuchen on 2017/10/8.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYBaseModel.h"

@interface YYRecordModel : YYBaseModel

//"lon": 119.968596635644,
//"ctime": "2017-07-20 14:31:28",
//"lat": 31.6801917648677
@property (nonatomic,assign) CGFloat lon;

@property (nonatomic,copy) NSString *ctime;

@property (nonatomic,assign) CGFloat lat;

@end
