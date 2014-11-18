//
//  DragAndDropUIGestureRecognizer.m
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "DragAndDropUIGestureRecognizer.h"

@implementation DragAndDropUIGestureRecognizer

- (id) initWithTarget:(id)target action:(SEL)action andStartingPosition:(CGPoint) startingPosition {
    self = [super initWithTarget:target action:action];
    if(self){
        self.startingPoint = startingPosition;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
//    UITouch * touch = [touches anyObject];
//    CGPoint position = [touch locationInView: self.view.superview];
//    //self.startingPoint = [touch locationInView:self.view];
//    self.touchOffset = CGPointMake(self.view.center.x-position.x,self.view.center.y-position.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView: self.view.superview];
    NSLog(@"touchesMoved to location %@", NSStringFromCGPoint(position));
    [UIView animateWithDuration:.001
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.view.center = position;
                         //self.view.center = CGPointMake(position.x+self.touchOffset.x, position.y+self.touchOffset.y);
                     }
                     completion:^(BOOL finished) {}];
    
}

- (void)resetState {
    //animate tile back to bottom
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.view.center = self.startingPoint;
                     }
                     completion:^(BOOL finished) {}];
    
//    if (self.state == UIGestureRecognizerStatePossible) {
//        [self setState:UIGestureRecognizerStateFailed];
//    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    [self resetState];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled");
    [self resetState];
}

@end
