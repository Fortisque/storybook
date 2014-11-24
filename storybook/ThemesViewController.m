//
//  BubbleThemesViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/21/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _logoImage.image = [UIImage imageNamed:@"storybubblesF"];
    [self spawnBubbles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)spawnBubbles
{
    // Configure the particle emitter to the top edge of the screen
    CAEmitterLayer *bubbleEmitter = [CAEmitterLayer layer];
    bubbleEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height + 30);
    bubbleEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);
    
    // Spawn points for the bubbles are within on the outline of the line
    bubbleEmitter.emitterMode		= kCAEmitterLayerOutline;
    bubbleEmitter.emitterShape	= kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *bubble = [CAEmitterCell emitterCell];
    
    bubble.birthRate		= 1.0;
    bubble.lifetime		= 120.0;
    
    bubble.velocity		= 10;				// inital speed going down
    bubble.velocityRange = 10;
    bubble.yAcceleration = -4;              // quickly accelerating up
    bubble.emissionRange = 1.0 * M_PI;		// some variation in angle
    bubble.spinRange		= 1.0 * M_PI;		// medium spin
    
    bubble.contents		= (id) [[UIImage imageNamed:@"bubble_preview"] CGImage];
    bubble.color			= [[UIColor colorWithRed:0.100 green:0.758 blue:0.743 alpha:.6] CGColor];
    
    // Make the bubbles seem inset in the background
    bubbleEmitter.shadowOpacity = 1.0;
    bubbleEmitter.shadowRadius  = 0.0;
    bubbleEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    bubbleEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    bubbleEmitter.emitterCells = [NSArray arrayWithObject:bubble];
    [self.view.layer insertSublayer:bubbleEmitter atIndex:0];
}

@end
