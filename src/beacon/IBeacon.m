//
//  IBeacon.m
//  beacon
//
//  Created by Paul Jackson on 25/07/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import "IBeacon.h"

@import IOBluetooth;

static NSString const * kBeaconKey = @"kCBAdvDataAppleBeaconKey";

@interface IBeacon() <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager   *manager;
@property (nonatomic, assign) BOOL                  powerOn;
@property (nonatomic, assign) BOOL                  isAdvertising;

@end

@implementation IBeacon

- (instancetype)initWithUUID:(NSString *)uuid
                       major:(uint16_t)major
                       minor:(uint16_t)minor
                       power:(uint8_t)power
                        name:(NSString *)name;
{
    if (self = [super init]) {
        _uuid  = uuid;
        _major = major;
        _minor = minor;
        _power = power;
        _name  = name;
        
        _powerOn = NO;
        _manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    
    return self;
}

#pragma mark - Public

- (void)start
{
    if (!self.powerOn) {
        [self showNoPowerAlert];
        return;
    }
    
    if (self.manager.isAdvertising) {
        return;
    }
    
    [self.manager startAdvertising:self.advertisement];
}

- (void)stop
{
    if (!self.manager.isAdvertising) {
        return;
    }
    
    [self.manager stopAdvertising];
}

#pragma mark - Helper

- (NSDictionary *)advertisement
{
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:self.uuid];

    unsigned char advertisementBytes[21] = {0};
    [proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];
    advertisementBytes[16] = (unsigned char)(self.major >> 8);
    advertisementBytes[17] = (unsigned char)(self.major & 255);
    advertisementBytes[18] = (unsigned char)(self.minor >> 8);
    advertisementBytes[19] = (unsigned char)(self.minor & 255);
    advertisementBytes[20] = self.power;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];
    return [NSDictionary dictionaryWithObject:advertisement forKey:kBeaconKey];
}

- (void)showNoPowerAlert
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Bluetooth is not on"];
    [alert setInformativeText:@"To start advertising with this beacon you must turn on Bluetooth."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}

- (void)showErrorAlert:(NSError*)error
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Error advertising iBeacon"];
    [alert setInformativeText:error.userInfo.description];
    [alert setAlertStyle:NSCriticalAlertStyle];
    [alert runModal];
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            self.powerOn = YES;
            break;
            
        case CBPeripheralManagerStatePoweredOff:
        case CBPeripheralManagerStateResetting:
            self.powerOn = NO;
            break;

        default:
            break;
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error
{
    if (error) {
        [self showErrorAlert:error];
        return;
    }
    
    self.isAdvertising = peripheral.isAdvertising;
}

@end
