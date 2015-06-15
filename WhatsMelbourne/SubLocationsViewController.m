//
//  SubLocationsViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "SubLocationsViewController.h"

@interface SubLocationsViewController ()

@end

@implementation SubLocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locations = [NSMutableArray array];
    [self performAPIRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Location *location = [self.locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = location.locationName;
    cell.detailTextLabel.text = location.currentEvents;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showByLocation" sender:self];
}

- (void)performAPIRequest
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.eventfinda.com.au/v2/locations.json?levels=2&id=%@",_parentId];
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
    NSDictionary *melbDictionary = locationsArray[0];
    
    NSDictionary *children = [melbDictionary objectForKey:@"children"];
    NSDictionary *areasArray = [children objectForKey:@"children"];
    for (NSDictionary *locationDictionary in areasArray) {
        NSInteger eventNo = [[locationDictionary objectForKey:@"count_current_events"] integerValue];
        if (eventNo != 0) {
            Location *location = [Location locationWithName:[locationDictionary objectForKey:@"name"]];
            location.locationName = [locationDictionary objectForKey:@"name"];
            location.locationId = [[locationDictionary objectForKey:@"id"] stringValue];
            location.currentEvents = [[locationDictionary objectForKey:@"count_current_events"] stringValue];
            [self.locations addObject:location];
        }
    }
    
    [self.tableView reloadData];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showByLocation"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Location *location = [self.locations objectAtIndex:indexPath.row];
        EventsViewController *ewc = (EventsViewController *)segue.destinationViewController;
        ewc.locationSearch = location.locationId;
        NSLog(@"%@", location.locationId);
    }
}

@end
