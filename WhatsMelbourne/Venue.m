//
//  Venue.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id) initWithName:(NSString *)name {
    self = [super init];
    
    if ( self ){
        self.name = name;
        self.venueId = nil;
        self.currentEvents = nil;
    }
    
    return self;
}

+ (id) venueWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

@end
