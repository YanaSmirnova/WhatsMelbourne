//
//  SubLocationsViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "EventsViewController.h"

@interface SubLocationsViewController : UITableViewController

@property (nonatomic, strong) NSMutableData *apiData;
@property (nonatomic, strong) NSMutableArray *locations;
@property (strong, nonatomic) NSString *parentId;

@end
