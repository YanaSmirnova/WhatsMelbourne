//
//  Networker.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "Networker.h"

@implementation Networker

- (void)performAPIRequest
{
    NSString *urlString = @"http://api.eventfinda.com.au/v2/locations.json?levels=2&id=20";
    NSLog(@"Performing request");
    
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
    self.apiResponse = [NSJSONSerialization JSONObjectWithData:self.apiData options:kNilOptions error:nil];
}

@end
