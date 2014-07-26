//
//  IBeacon.h
//  beacon
//
//  Created by Paul Jackson on 25/07/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBeacon : NSObject

@property (nonatomic, strong) NSString  *uuid;
@property (nonatomic, assign) uint16_t  major;
@property (nonatomic, assign) uint16_t  minor;
@property (nonatomic, assign) uint8_t   power;
@property (nonatomic, strong) NSString  *name;

@property (nonatomic, readonly) BOOL isAdvertising;

- (instancetype)initWithUUID:(NSString *)uuid
                       major:(uint16_t)major
                       minor:(uint16_t)minor
                       power:(uint8_t)power
                        name:(NSString*)name;

- (void)start;
- (void)stop;

@end