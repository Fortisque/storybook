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
    CGRect frame = [[properties objectForKey:@"frame"] CGRectValue];
    self = [super initWithFrame:frame];
    if(self){
        _properties = properties;
        self.backgroundColor = [UIColor yellowColor];
        
        // initilize all your UIView components
        NSString *letter = [properties objectForKey:@"letter"];
        NSString *imageName = [properties objectForKey:@"imageName"];
        
        if (letter) {
            _letter = letter;
            _letterLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,30, 200, 44)];
            _letterLabel.text = _letter;
            [self addSubview:_letterLabel];
        }
        if (imageName) {
            _imageView = [[UIImageView alloc]initWithFrame:frame];
            _imageView.image = [UIImage imageNamed:imageName];
        }
        
        [self addSubview:_imageView];
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

/*- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        //load xib
        [[NSBundle mainBundle] loadNibNamed:@"TileView" owner:self options:nil];
        //set bound
        self.bounds = self.view.bounds;
        //add view
        [self addSubview:self.view];
    }
    return self;
}
*/
@end
