//
//  DataService.h
//  beacon
//
//  Created by Paul Jackson on 28/07/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IBeacon;

@interface DataService : NSObject

+ (NSArray *)loadAll;
+ (void)add:(IBeacon *)beacon;
+ (void)remove:(IBeacon *)beacon;

@end
