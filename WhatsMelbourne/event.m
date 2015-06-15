//
//  Event.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if ( self ){
        self.title = title;
        self.dateSummary = nil;
        self.thumbnail = nil;
        self.url = nil;
    }
    
    return self;
}

+ (id) eventWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    return [NSURL URLWithString:self.thumbnail];
}

@end
