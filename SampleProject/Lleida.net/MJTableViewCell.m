//
//  MJTableViewCell.m
//  Lleida.net
//
//  Created by Joan Martin on 18/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "MJTableViewCell.h"

@implementation MJTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:113.0/255.0 blue:180.0/255.0 alpha:1.0];
    self.selectedBackgroundView = backgroundView;
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end
