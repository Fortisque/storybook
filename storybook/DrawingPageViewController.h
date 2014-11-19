//
//  DrawingPageViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/18/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageViewController.h"
#import "DrawingPrompterViewController.h"

@interface DrawingPageViewController : BasePageViewController <UIGestureRecognizerDelegate> {
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (weak, nonatomic) DrawingPrompterViewController *presenter;

- (IBAction)colorPressed:(id)sender;

- (IBAction)eraserPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
