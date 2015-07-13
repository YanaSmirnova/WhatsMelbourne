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
#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SavedEventViewController ()

@end

@implementation SavedEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleLabel setText:self.eventTitle];
    [self.dateLabel setText:self.eventDateSum];
    [self.venueLabel setText:self.eventVenue];
    [self.addressButton setTitle:self.eventAddress forState:UIControlStateNormal];
    
    UIImage *imageToShow = nil;
    
    if (self.eventImageBig == nil) {
        imageToShow = [UIImage imageWithData:self.eventImageThumb];
    } else {
        imageToShow = [UIImage imageWithData:self.eventImageBig];
    }
    
    self.imageThumb.image = imageToShow;
    
    self.imageThumb.layer.cornerRadius = 10;
    self.imageThumb.clipsToBounds = YES;
    
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showMap"]){
        
        MapViewController *mvc = (MapViewController *)segue.destinationViewController;
        mvc.eventVenue = self.eventVenue;
        mvc.eventAddress = self.eventAddress;
        mvc.eventLat = self.eventLat;
        mvc.eventLng = self.eventLng;
    }
}

@end
