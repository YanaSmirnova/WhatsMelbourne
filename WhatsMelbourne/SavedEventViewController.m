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
    
    if (self.eventImageData == nil) {
        self.imageThumb.image = [UIImage imageNamed:@"square.png"];
    } else {
        UIImage *image = [UIImage imageWithData:self.eventImageData];
        self.imageThumb.image = image;
    }
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"])
    {
        NSLog(@"OK was selected.");
        
        NSString *deleteName = self.eventTitle;
        NSEntityDescription *productEntity=[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
        [fetch setEntity:productEntity];
        NSPredicate *p=[NSPredicate predicateWithFormat:@"title == %@", deleteName];
        [fetch setPredicate:p];
        NSError *fetchError;
        NSArray *fetchedProducts=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];
        // handle error
        for (NSManagedObject *product in fetchedProducts) {
            [self.managedObjectContext deleteObject:product];
        }
    }
    else if([title isEqualToString:@"Cancel"])
    {
        NSLog(@"Cancel was selected.");
        //        [self cancelSaving];
    }
}

@end
