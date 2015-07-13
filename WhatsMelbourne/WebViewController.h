//
//  WebViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface WebViewController : UIViewController <UIAlertViewDelegate>

@property int eventId;
@property (strong, nonatomic) NSURL *eventURL;
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDateSum;
@property (strong, nonatomic) NSURL *eventThumbURL;
@property (strong, nonatomic) NSURL *eventBiggerURL;
@property (strong, nonatomic) NSString *eventVenue;
@property (strong, nonatomic) NSString *eventAddress;
@property (nonatomic, strong) NSNumber *eventLat;
@property (nonatomic, strong) NSNumber *eventLng;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEventBtn;

- (IBAction)addEvent:(id)sender;


@end
