//
//  LocationsViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "LocationsViewController.h"

@interface LocationsViewController ()

@end

@implementation LocationsViewController

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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Location *location = [self.locations objectAtIndex:indexPath.row];
   
    cell.textLabel.text = location.locationName;
    cell.detailTextLabel.text = location.locationId;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showLocations" sender:self];
}

- (void)performAPIRequest
{
    NSString *urlString = @"http://api.eventfinda.com.au/v2/locations.json?levels=2&id=20";
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
        Location *location = [Location locationWithName:[locationDictionary objectForKey:@"name"]];
        location.locationName = [locationDictionary objectForKey:@"name"];
        NSLog(@"Name is: %@",location.locationName);
        location.locationId = [[locationDictionary objectForKey:@"id"] stringValue];
        NSLog(@"Name is: %@",location.locationId);
        [self.locations addObject:location];
    }
    
    [self.tableView reloadData];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"preparing for segue: %@",segue.identifier);
    
    if ( [segue.identifier isEqualToString:@"showLocations"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Location *location = [self.locations objectAtIndex:indexPath.row];
        VenuesViewController *vwc = (VenuesViewController *)segue.destinationViewController;
        vwc.locationID = location.locationId;
        
    }
}

@end
