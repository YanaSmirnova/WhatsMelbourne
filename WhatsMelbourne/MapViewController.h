//
//  MapViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 13/07/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController

@property (strong, nonatomic) NSString *eventAddress;
@property (strong, nonatomic) NSString *eventVenue;
@property (nonatomic, strong) NSNumber *eventLat;
@property (nonatomic, strong) NSNumber *eventLng;

@end
