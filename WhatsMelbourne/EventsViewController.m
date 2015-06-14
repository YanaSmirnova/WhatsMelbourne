//
//  EventsViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.events = [NSMutableArray array];
    [self performAPIRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    if ( [event.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:event.thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];        
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"image.png"];
    }

    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = event.dateSummary;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)performAPIRequest
{
    NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.eventfinda.com.au/v2/events.json?rows=2"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:apiRequest delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"whatsmelbourne"
                                                                password:@"ghx2cp54rx4w"
                                                             persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.apiData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.apiData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:self.apiData options:kNilOptions error:nil];
    NSArray *eventsArray = [apiResponse objectForKey:@"events"];
    
    for (NSDictionary *eventDictionary in eventsArray) {
        NSLog(@"%@", [eventDictionary objectForKey:@"name"]);
        NSLog(@"%@", [eventDictionary objectForKey:@"datetime_summary"]);
        NSString *thumbnailImage = nil;
        
        NSDictionary *images = [eventDictionary objectForKey:@"images"];
        NSArray *image_collection = [images objectForKey:@"images"];
        for (NSDictionary *image in image_collection) {
            
            if ([[image objectForKey:@"is_primary"] integerValue] == 1) {
                NSDictionary *transforms = [image objectForKey:@"transforms"];
                NSArray *transform_collection = [transforms objectForKey:@"transforms"];
                for (NSDictionary *transform in transform_collection) {
                    if ([[transform objectForKey:@"transformation_id"] integerValue] == 15) {
                        NSLog(@"%@", [transform objectForKey:@"url"]);
                        thumbnailImage = [transform objectForKey:@"url"];
                    }
                }
            }
        }
        
        Event *event = [Event eventWithTitle:[eventDictionary objectForKey:@"name"]];
        event.dateSummary = [eventDictionary objectForKey:@"datetime_summary"];
        event.thumbnail = thumbnailImage;
        
        [self.events addObject:event];

        [self.tableView reloadData];
    }
}

@end
