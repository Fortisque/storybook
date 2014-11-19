//
//  Tile.h
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;
@property (strong, nonatomic) NSString *letter;

- (instancetype) initWithLetter: (NSString *) letter;

@property BOOL matched;
@property CGPoint originalPosition;
//@property CGPoint touchOffset;

@end
