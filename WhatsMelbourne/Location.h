//
//  Location.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *currentEvents;

- (id) initWithName:(NSString *)name;
+ (id) locationWithName:(NSString *)name;

@end
