//
//  UIBorderedLabel.m
//  storybook
//
//  Created by Kevin Casey on 11/30/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "UIBorderedLabel.h"

@implementation UIBorderLabel

@synthesize topInset, leftInset, bottomInset, rightInset;

- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {self.topInset, self.leftInset,
        self.bottomInset, self.rightInset};
    
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
