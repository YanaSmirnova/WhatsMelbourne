//
//  Networker.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "Networker.h"

@implementation Networker

- (void)performAPIRequest:(NSURL *)url
{
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
                    }
                }
            }
            
            Event *event = [Event eventWithTitle:[eventDictionary objectForKey:@"name"]];
            event.dateSummary = [eventDictionary objectForKey:@"datetime_summary"];
            event.url = [NSURL URLWithString:[eventDictionary objectForKey:@"url"]];
            event.venue = [eventDictionary objectForKey:@"address"];
            event.thumbnail = thumbnailImage;
            
            [self.events addObject:event];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
    [task resume];
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
    self.apiResponse = [NSJSONSerialization JSONObjectWithData:self.apiData options:kNilOptions error:nil];
}

@end
