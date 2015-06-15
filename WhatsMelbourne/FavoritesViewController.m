//
//  FavoritesViewController.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 15/06/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Event"];
    self.events = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        
    [self.tableView reloadData];
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
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSManagedObject *event = [self.events objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [event valueForKey:@"title"]]];
    [cell.detailTextLabel setText:[event valueForKey:@"dateSummary"]];
//    [cell.imageView setImage: [UIImage imageNamed:@"circle.png"]];


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showSavedEvent" sender:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"preparing for segue: %@",segue.identifier);
    
    if ( [segue.identifier isEqualToString:@"showSavedEvent"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Event *event = [self.events objectAtIndex:indexPath.row];
        SavedEventViewController *sevc = (SavedEventViewController *)segue.destinationViewController;
//        sevc.eventURL = event.url;
        sevc.eventTitle = event.title;
        sevc.eventDateSum = event.dateSummary;
    }
}


@end
