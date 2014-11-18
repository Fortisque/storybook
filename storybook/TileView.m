//
//  Tile.m
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "TileView.h"

@implementation TileView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect mFrame = self.bounds;
//    CGContextSetLineWidth(context, 10);
//    [[UIColor brownColor] set];
//    UIRectFrame(mFrame);
//}

- (instancetype) initWithLetter: (NSString *) letter{
    self = [super init];
    if(self){
        self.letter = letter;
        self.letterLabel.text = letter;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        //load xib
        [[NSBundle mainBundle] loadNibNamed:@"TileView" owner:self options:nil];
        //add view
        [self addSubview:self.view];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        //load xib
        [[NSBundle mainBundle] loadNibNamed:@"TileView" owner:self options:nil];
        //set bound
        NSLog(@"Frame: %@", NSStringFromCGRect(self.view.bounds));
        self.bounds = self.view.bounds;
        //add view
        [self addSubview:self.view];
    }
    return self;
}

@end
