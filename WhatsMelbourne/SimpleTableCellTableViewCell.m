//
//  SimpleTableCellTableViewCell.m
//  WhatsMelbourne
//
//  Created by YANA SMIRNOVA on 7/07/2015.
//  Copyright (c) 2015 YANA SMIRNOVA. All rights reserved.
//

#import "SimpleTableCellTableViewCell.h"

@implementation SimpleTableCellTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize prepTimeLabel = _prepTimeLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
