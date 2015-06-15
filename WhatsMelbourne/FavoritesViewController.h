//
//  FavoritesViewController.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "SavedEventViewController.h"
#import <CoreData/CoreData.h>

@interface FavoritesViewController : UITableViewController <UIAlertViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
