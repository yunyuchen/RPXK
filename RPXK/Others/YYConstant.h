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
UIKIT_EXTERN NSString *const kBluetoothDisconnectNotification;
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
//添加车辆API
UIKIT_EXTERN NSString *const kAddBikeAPI;
//删除车辆API
UIKIT_EXTERN NSString *const kDelBikeAPI;
//我的车辆
UIKIT_EXTERN NSString *const kMyBikesAPI;
//监测BLE
UIKIT_EXTERN NSString *const kCheckBleAPI;
//消息
UIKIT_EXTERN NSString *const kPushMsgAPI;
//设置主要设备
UIKIT_EXTERN NSString *const kSetMainDeviceAPI;
//车辆定位
UIKIT_EXTERN NSString *const kLocationAPI;
//车辆轨迹数据
UIKIT_EXTERN NSString *const kGPSInfoAPI;
@end
