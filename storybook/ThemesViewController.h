//
//  BubbleThemesViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/21/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animations.h"
#import "Helper.h"
#import "iCarousel.h"
#import "DictionaryKeys.h"

@interface ThemesViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) IBOutlet iCarousel *carousel;

@end
