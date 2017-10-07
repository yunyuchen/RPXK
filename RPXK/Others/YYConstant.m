//
//  YYConstant.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/25.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYConstant.h"

@implementation YYConstant

NSString *const kSelectedPhotosChangeNotification = @"SelectedPhotosChangeNotification";
NSString *const kNHRequestSuccessNotification = @"NHRequestSuccessNotification";
NSString *const kLoginSuccessNotification = @"LoginSuccessNotification";
NSString *const kLogoutSuccessNotification = @"LogoutSuccessNotification";
NSString *const kBluetoothDisconnectNotification = @"BluetoothDisconnectNotification";

NSString *const kBaseURL = @"http://120.27.21.73/";

NSString *const kLoginBytelAPI = @"open/get?module=UserService.loginBytel";

NSString *const kGetTokenAPI = @"open/get?module=CodeService.getToken";

NSString *const kSendCodeAPI = @"open/get?module=CodeService.sendCodeByToken";

NSString *const kUserInfoAPI = @"get?module=UserService.userinfo";

NSString *const kAddBikeAPI = @"get?module=DeviceService.addBike";

NSString *const kDelBikeAPI = @"get?module=DeviceService.delBike";

NSString *const kMyBikesAPI = @"get?module=DeviceService.myBikes";

NSString *const kCheckBleAPI = @"get?module=DeviceService.checkBle";

NSString *const kPushMsgAPI = @"get?module=UserService.pushmsg";

NSString *const kSetMainDeviceAPI = @"get?module=DeviceService.setMainDevice";

NSString *const kLocationAPI = @"get?module=DeviceService.location";

NSString *const kGPSInfoAPI = @"get?module=DeviceService.gpsinfo";
@end
