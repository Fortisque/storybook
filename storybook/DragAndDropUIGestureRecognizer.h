//
//  DragAndDropUIGestureRecognizer.h
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragAndDropUIGestureRecognizer : UIGestureRecognizer

@property (assign) CGPoint startingPoint;
@property (assign) CGPoint touchOffset;

- (id) initWithTarget:(id)target action:(SEL)action andStartingPosition:(CGPoint) startingPosition;

@end
