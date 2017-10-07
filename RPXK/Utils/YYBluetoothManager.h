//
//  YYBluetoothManager.h
//  RPXK
//
//  Created by yunyuchen on 2017/9/30.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol YYBluetoothManagerDelegate<NSObject>

@optional
- (void)updateWithSpeed:(CGFloat)speed andBattery:(CGFloat)battery;
- (void)shakeHandSuccess;

@end


typedef void (^YYBLEConnectPeripheralStateBlock)(BOOL connectState);
typedef void (^YYExameBluetoothStateBlock)(BOOL isPowerOn);

@interface YYBluetoothManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)hasConnectPeripheral;

- (void)connectPeripheralWithStateCallback:(YYBLEConnectPeripheralStateBlock)connectStateCallback
                           examBLECallback:(YYExameBluetoothStateBlock)examCallback;

- (void) openSeat;
@property(nonatomic,weak) id<YYBluetoothManagerDelegate> delegate;

@end
