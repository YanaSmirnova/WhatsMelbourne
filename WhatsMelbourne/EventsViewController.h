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
#import "Reachability.h"

@interface EventsViewController : UITableViewController <NSURLConnectionDelegate>
{
    Reachability *internetReachableFoo;
}

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSString *locationSearch;
@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UINavigationItem *eventsTitle;

- (void)testInternetConnection;

@end
