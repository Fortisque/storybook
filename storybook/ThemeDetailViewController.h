//
//  ThemeDetailViewController.h
//  storybook
//
//  Created by Gavin Chu on 11/25/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeStoriesCollectionViewController.h"
#import "BookDetailViewController.h"

@interface ThemeDetailViewController : UIViewController


@property (strong, nonatomic) ThemeStoriesCollectionViewController *collectionViewController;
@property (strong, nonatomic) BookDetailViewController *bookDetailViewController;
@property (strong, nonatomic) IBOutlet UIView *bookDetailView;
@property (strong, nonatomic) IBOutlet UIView *storiesCollectionView;
@property (strong, nonatomic) IBOutlet UIView *themeView;

@property (weak, nonatomic) IBOutlet UIButton *upArrow;
@property (weak, nonatomic) IBOutlet UIButton *downArrow;

- (IBAction)upArrowClicked:(UIButton *)sender;
- (IBAction)downArrowClicked:(UIButton *)sender;

- (void)openBookDetailView;
- (void)closeBookDetailView;

- (void)loadBookDetailTitle:(NSString *)title
                     Author:(NSString *)author
                  BookCover:(NSString *)imageName
                Description:(NSString *)description
                     Bought:(BOOL)bought;

@property BOOL bookDetailOpened;

@end
