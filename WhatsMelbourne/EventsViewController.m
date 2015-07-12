//
//  EventsViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 14/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController () <NSURLSessionDelegate>

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
    
    if (self.locationSearch != nil) {
        NSMutableString *eventAtLocation = [[NSMutableString alloc]initWithString:@"Events in "];
        [eventAtLocation appendString:self.locationName];
        NSString *eventAtLocationString = [NSString stringWithString:eventAtLocation];
        [self.eventsTitle setTitle:eventAtLocationString];
    }    
    
    self.events = [NSMutableArray array];
    
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
    return [self.events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    if ( [event.thumbnail isKindOfClass:[NSString class]]) {
        NSURL *thumbnailURL = [event imageURL:event.thumbnail];
        NSData *imageData = [NSData dataWithContentsOfURL:thumbnailURL];
        UIImage *image = [UIImage imageWithData:imageData];        
        cell.thumbnailImageView.image = image;
    } else {
        cell.thumbnailImageView.image = [UIImage imageNamed:@"square.png"];
    }
    
    cell.nameLabel.text = event.title;
    cell.dateLabel.text = event.dateSummary;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showEvent" sender:self];
}

- (void)performAPIRequest
{
    NSString *urlString = @"http://api.eventfinda.com.au/v2/events.json?location=20";
    if (self.locationSearch != nil) {
        urlString = [NSString stringWithFormat:@"http://api.eventfinda.com.au/v2/events.json?location=%@",_locationSearch];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    NSString *authStr = @"whatsmelbourne:ghx2cp54rx4w";
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSArray *eventsArray = [responseDictionary objectForKey:@"events"];
        
            for (NSDictionary *eventDictionary in eventsArray) {
                
                NSString *thumbnailImage = nil;
                NSString *biggerImage = nil;
        
                NSDictionary *images = [eventDictionary objectForKey:@"images"];
                NSArray *image_collection = [images objectForKey:@"images"];
                for (NSDictionary *image in image_collection) {
        
                    if ([[image objectForKey:@"is_primary"] integerValue] == 1) {
                        NSDictionary *transforms = [image objectForKey:@"transforms"];
                        NSArray *transform_collection = [transforms objectForKey:@"transforms"];
                        for (NSDictionary *transform in transform_collection) {
                            if ([[transform objectForKey:@"transformation_id"] integerValue] == 15) {
                                thumbnailImage = [transform objectForKey:@"url"];
                            }
                            if ([[transform objectForKey:@"transformation_id"] integerValue] == 8) {
                                biggerImage = [transform objectForKey:@"url"];
                            }
                        }
                    }
                }
        
                Event *event = [Event eventWithTitle:[eventDictionary objectForKey:@"name"]];
                event.dateSummary = [eventDictionary objectForKey:@"datetime_summary"];
                event.url = [NSURL URLWithString:[eventDictionary objectForKey:@"url"]];
                event.venue = [eventDictionary objectForKey:@"address"];
                event.thumbnail = thumbnailImage;
                NSLog(@"Thumbnail: %@", thumbnailImage);
                if (biggerImage == nil) {
                    event.biggerImage = thumbnailImage;
                }
                else {
                    event.biggerImage = biggerImage;
                }                
                NSLog(@"Bigger: %@", biggerImage);
                
                [self.events addObject:event];
        
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
    }];
    
    [task resume];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"showEvent"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Event *event = [self.events objectAtIndex:indexPath.row];
        WebViewController *wbc = (WebViewController *)segue.destinationViewController;
        wbc.eventURL = event.url;
        wbc.eventTitle = event.title;
        wbc.eventDateSum = event.dateSummary;
        wbc.eventVenue = event.venue;             
        wbc.eventThumbURL = [event imageURL:event.thumbnail];
        wbc.eventBiggerURL = [event imageURL:event.biggerImage];
    }
}

@end
