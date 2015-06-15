//
//  Venue.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *currentEvents;

- (id) initWithName:(NSString *)name;
+ (id) venueWithName:(NSString *)name;

@end
