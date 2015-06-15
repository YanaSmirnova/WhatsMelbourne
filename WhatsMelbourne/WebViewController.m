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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    [newEvent setValue:self.eventTitle forKey:@"title"];
    [newEvent setValue:self.eventDateSum forKey:@"dateSummary"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)UIAlertViewmessageUIAlertViewallocinitWithTitleHelloWorldmessageThisisyourfirstUIAlertviewmessagedelegatenilcancelButtonTitleOKotherButtonTitlesniladdEvent:(id)sender {
}
- (IBAction)addEvent:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                      message:@"This is your first UIAlertview message."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}
@end
