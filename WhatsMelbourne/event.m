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
    }
    
    return self;
}

+ (id) eventWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (NSURL *) thumbnailURL {
    return [NSURL URLWithString:self.thumbnail];
}

//- (NSString *) formattedDate {
//    
//    // format from 2014-11-09 10:00:00 to "EE MMM,dd"
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *tempDate = [dateFormatter dateFromString:self.startDate];
//    
//    [dateFormatter setDateFormat:@"EE MMM,dd"];
//    return [dateFormatter stringFromDate:tempDate];
//    
//}

@end
