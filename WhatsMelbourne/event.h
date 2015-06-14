//
//  Event.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, strong) NSURL *url;

- (id) initWithTitle:(NSString *)title;
+ (id) eventWithTitle:(NSString *)title;

- (NSString *) formattedDate;

@end
