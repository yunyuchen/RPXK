//
//  YYConstant.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/25.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYConstant : NSObject

UIKIT_EXTERN NSString *const kSelectedPhotosChangeNotification;
UIKIT_EXTERN NSString *const kNHRequestSuccessNotification;
UIKIT_EXTERN NSString *const kLoginSuccessNotification;
UIKIT_EXTERN NSString *const kLogoutSuccessNotification;
/** 基础URL*/
UIKIT_EXTERN NSString *const kBaseURL;
/** 登录*/
UIKIT_EXTERN NSString *const kLoginBytelAPI;
/** 获取Token*/
UIKIT_EXTERN NSString *const kGetTokenAPI;
UIKIT_EXTERN NSString *const kSendCodeAPI;
//登录
UIKIT_EXTERN NSString *const kLoginBytelAPI;
//用户信息
UIKIT_EXTERN NSString *const kUserInfoAPI;
@end
