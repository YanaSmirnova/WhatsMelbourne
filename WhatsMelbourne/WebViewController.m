//
//  WebViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.eventURL];
    [self.webView loadRequest:urlRequest];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)cancelSaving {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveToCore {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    
    NSNumber *idNumber = [NSNumber numberWithInt:self.eventId];
    [newEvent setValue:idNumber forKey:@"id"];
    
    [newEvent setValue:self.eventTitle forKey:@"title"];
    [newEvent setValue:self.eventDateSum forKey:@"dateSummary"];
    
    NSData *biggerImageData = [NSData dataWithContentsOfURL:self.eventBiggerURL];
    [newEvent setValue:biggerImageData forKey:@"imageBig"];
    
    NSData *thumbImageData = [NSData dataWithContentsOfURL:self.eventThumbURL];
    [newEvent setValue:thumbImageData forKey:@"imageThumb"];
    
    [newEvent setValue:self.eventVenue forKey:@"venue"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addEvent:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Add to Favorites"
                                                      message:@"Do you want to store details of this event?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"OK", nil];
    
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"])
    {
        NSLog(@"OK was selected.");
        [self saveToCore];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else if([title isEqualToString:@"Cancel"])
    {
        NSLog(@"Cancel was selected.");
        [self cancelSaving];
    }
}

@end
