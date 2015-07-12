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
        self.biggerImage = nil;
        self.url = nil;
        self.venue = nil;
    }
    
    return self;
}

+ (id) eventWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) imageURL:(NSString *)imageString {
    return [NSURL URLWithString:imageString];
}

@end
