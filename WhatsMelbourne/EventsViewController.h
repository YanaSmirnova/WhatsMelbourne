//
//  EventsViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "WebViewController.h"
#import "SimpleTableCell.h"

@interface EventsViewController : UITableViewController <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *apiData;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSString *locationSearch;

@end
