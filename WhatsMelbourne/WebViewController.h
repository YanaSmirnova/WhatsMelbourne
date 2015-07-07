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

@property (strong, nonatomic) NSURL *eventURL;
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDateSum;
@property (strong, nonatomic) NSData *eventImage;
//@property (strong, nonatomic) NSString *eventVenue;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addEventBtn;

- (IBAction)addEvent:(id)sender;


@end
