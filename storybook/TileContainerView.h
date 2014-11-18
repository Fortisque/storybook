//
//  TileContainerView.h
//  storybook
//
//  Created by Gavin Chu on 11/18/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"

@interface TileContainerView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) TileView *containedTile;
@property (strong, nonatomic) NSString *containedLetter;

@end
