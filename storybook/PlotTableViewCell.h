//
//  PlotTableViewCell.h
//  storybook
//
//  Created by Kevin Casey on 11/22/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlotTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *plotLabel;
@property (strong, nonatomic) IBOutlet UILabel *indexLabel;

@end
