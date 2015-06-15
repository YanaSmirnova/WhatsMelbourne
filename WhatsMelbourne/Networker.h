//
//  Networker.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networker : NSObject <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *apiData;
@property (nonatomic, strong) NSDictionary *apiResponse;

- (void)performAPIRequest;

@end
