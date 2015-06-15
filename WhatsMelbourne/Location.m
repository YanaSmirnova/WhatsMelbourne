//
//  Location.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithName:(NSString *)name {
    self = [super init];
    
    if ( self ){
        self.locationName = name;
        self.locationId = nil;
    }
    
    return self;
}

+ (id) locationWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

@end
