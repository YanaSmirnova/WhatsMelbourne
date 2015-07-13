//
//  SavedEventViewController.m
//  WhatsMelbourne
//
//  Created by swin on 16/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "SavedEventViewController.h"
#import "Event.h"
#import <CoreData/CoreData.h>

@interface SavedEventViewController ()

@end

@implementation SavedEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleLabel setText:self.eventTitle];
    [self.dateLabel setText:self.eventDateSum];
    [self.venueButton setTitle:self.eventVenue forState:UIControlStateNormal];
    
    if (self.eventImageBig == nil) {
        self.imageThumb.image = [UIImage imageWithData:self.eventImageThumb];
    } else {
        self.imageThumb.image = [UIImage imageWithData:self.eventImageBig];
    }
    
    NSLog(@"Coordinates: %@ - %@", self.eventLat, self.eventLng);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeEvent:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Remove from Favorites"
                                                      message:@"Do you want to remove this event?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"OK", nil];
    
    [message show];}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"])
    {
        NSLog(@"OK was selected.");
        
        NSNumber *deleteId = self.eventId;
        NSEntityDescription *eventEntity=[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
        [fetch setEntity:eventEntity];
        NSPredicate *p=[NSPredicate predicateWithFormat:@"id == %@", deleteId.stringValue];
        [fetch setPredicate:p];
        NSError *fetchError = nil;
        NSArray *fetchedEvents=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];
        // handle error
        for (NSManagedObject *event in fetchedEvents) {
            [self.managedObjectContext deleteObject:event];
        }
        [self.managedObjectContext save:&fetchError];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if([title isEqualToString:@"Cancel"])
    {
        NSLog(@"Cancel was selected.");
        //        [self cancelSaving];
    }
}

@end
