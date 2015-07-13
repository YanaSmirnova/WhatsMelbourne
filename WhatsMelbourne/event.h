//
//  Event.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property int numberId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateSummary;
@property (nonatomic, strong) NSString *venue;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *biggerImage;
@property (nonatomic, strong) NSURL *url;

- (id) initWithTitle:(NSString *)title;
+ (id) eventWithTitle:(NSString *)title;

- (NSURL *) imageURL:(NSString *)imageString;

@end
