//
//  SavedEventViewController.h
//  WhatsMelbourne
//
//  Created by swin on 16/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedEventViewController : UIViewController <UIAlertViewDelegate>

//@property (nonatomic, strong) NSMutableArray *events;
@property (strong, nonatomic) NSURL *eventURL;
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDateSum;
@property (strong, nonatomic) NSString *eventVenue;
@property (strong, nonatomic) NSData *eventImageBig;
@property (strong, nonatomic) NSData *eventImageThumb;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)removeEvent:(id)sender;

@end

