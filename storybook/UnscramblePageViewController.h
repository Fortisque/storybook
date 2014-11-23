//
//  UnscrambleWordsViewController.h
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageViewController.h"

@interface UnscramblePageViewController : BasePageViewController

- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews andWord:(NSString *)word;
- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews andScenes:(NSArray *)scenes;

@end
