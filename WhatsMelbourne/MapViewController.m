//
//  MapViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 13/07/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.eventLat doubleValue]
                                                            longitude:[self.eventLng doubleValue]
                                                                 zoom:16];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.eventLat doubleValue], [self.eventLng doubleValue]);
    marker.title = self.eventVenue;
    marker.snippet = self.eventAddress;
    marker.map = mapView_;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
