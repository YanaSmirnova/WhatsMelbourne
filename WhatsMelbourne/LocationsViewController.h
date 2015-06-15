//
//  LocationsViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Venue.h"
#import "VenuesViewController.h"

@interface LocationsViewController : UITableViewController

@property (nonatomic, strong) NSMutableData *apiData;
@property (nonatomic, strong) NSMutableArray *venues;

@end
