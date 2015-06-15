//
//  VenuesViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "VenuesViewController.h"

@interface VenuesViewController()

@end

@implementation VenuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.venues = [NSMutableArray array];
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
    return [self.venues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Venue *venue = [self.venues objectAtIndex:indexPath.row];
    
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.currentEvents;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"showVenues" sender:self];
}

- (void)performAPIRequest
{
//    NSString *urlString = [NSString stringWithFormat:@"http://api.eventfinda.com.au/v2/locations.json?location=%@&venue=on",_subLocationID];
    NSString *urlString = [NSString stringWithFormat:@"http://api.eventfinda.com.au/v2/locations.json?location=8071&venue=on"];
    NSURLRequest *apiRequest    = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
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
    NSArray *locationsArray = [apiResponse objectForKey:@"locations"];
    for (NSDictionary *locationDictionary in locationsArray) {
        NSInteger eventNo = [[locationDictionary objectForKey:@"count_current_events"] integerValue];
//        if (eventNo != 0) {
            Venue *venue = [Venue venueWithName:[locationDictionary objectForKey:@"name"]];
            venue.currentEvents = [[locationDictionary objectForKey:@"count_current_events"] stringValue];
            [self.venues addObject:venue];
//        }        
    }
    
    [self.tableView reloadData];
}


//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"preparing for segue: %@",segue.identifier);
//    
//    if ( [segue.identifier isEqualToString:@"showVenues"]){
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Venue *venue = [self.venues objectAtIndex:indexPath.row];
//        VenuesViewController *vwc = (VenuesViewController *)segue.destinationViewController;
//        //        vwc.locationID = venue.suburb;
//        
//    }
//}

@end
