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

- (instancetype) initWithProperties:(NSDictionary *)properties {
    CGRect frame = [[properties objectForKey:kFrame] CGRectValue];
    self = [super initWithFrame:frame];
    if (self) {
        _properties = properties;
        self.backgroundColor = [UIColor yellowColor];
        
        // initilize all your UIView components
        NSString *letter = [properties objectForKey:@"letter"];
        NSString *imageName = [properties objectForKey:kImageName];
        NSString *sentence = [properties objectForKey:@"sentence"];

        
        if (letter) {
            _text = letter;
            _letterLabel = [[UILabel alloc]initWithFrame:frame];
            _letterLabel.text = letter;
            _letterLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_letterLabel];
        }
        
        if (imageName) {
            _imageView = [[UIImageView alloc]initWithFrame:frame];
            _imageView.image = [UIImage imageNamed:imageName];
            [self addSubview:_imageView];

        }
        
        if (sentence) {
            _text = sentence;
            _letterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 50, frame.size.width, 50)];
            _letterLabel.backgroundColor = [UIColor whiteColor];
            _letterLabel.text = sentence;
            _letterLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_letterLabel];
        }
        
        self.center = [[properties objectForKey:kCenter] CGPointValue];
        self.originalPosition = self.center;
        self.tag = [[properties objectForKey:kTag] integerValue];
        
    }
    return self;
}

@end
