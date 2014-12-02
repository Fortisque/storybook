//
//  Tile.h
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryKeys.h"
#import "Helper.h"

@interface TileView : UIView

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UILabel *letterLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSDictionary *properties;

- (instancetype) initWithProperties:(NSDictionary *)properties;
- (void) addShadow;
- (void) removeShadow;

@property BOOL matched;
@property CGPoint originalPosition;
@property BOOL scaledDown;

@end
