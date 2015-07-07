//
//  SimpleTableCellTableViewCell.h
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 7/07/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
