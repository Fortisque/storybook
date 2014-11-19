//
//  DrawingPageViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/18/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageViewController.h"

@interface DrawingPageViewController : BasePageViewController
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIImageView *tempDrawImage;

- (IBAction)colorPressed:(id)sender;

- (IBAction)eraserPressed:(id)sender;

@end
