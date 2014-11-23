//
//  Tile.h
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UILabel *letterLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *letter;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSDictionary *properties;

- (instancetype) initWithProperties:(NSDictionary *)properties;

@property BOOL matched;
@property CGPoint originalPosition;
//@property CGPoint touchOffset;

@end
