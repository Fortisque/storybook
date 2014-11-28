//
//  ThemeDetailViewController.h
//  storybook
//
//  Created by Gavin Chu on 11/25/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeStoriesCollectionViewController.h"

@interface ThemeDetailViewController : UIViewController

@property (strong, nonatomic) UIView *themeView;
@property (strong, nonatomic) ThemeStoriesCollectionViewController *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *upArrow;
@property (weak, nonatomic) IBOutlet UIButton *downArrow;

- (IBAction)upArrowClicked:(UIButton *)sender;
- (IBAction)downArrowClicked:(UIButton *)sender;

@end
