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
    [self throwFireworks];
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

- (void)throwFireworks
{
    // Cells spawn in the bottom, moving up
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0.0);
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
    rocket.velocity			= 600;
    rocket.velocityRange	= 100;
    rocket.yAcceleration	= 75;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    rocket.scale			= 0.2;
    rocket.color			= [[UIColor redColor] CGColor];
    rocket.greenRange		= 1.0;		// different colors
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    rocket.spinRange		= M_PI;		// slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0;
    burst.scale				= 2.5;
    burst.redSpeed			=-1.5;		// shifting
    burst.blueSpeed			=+1.5;		// shifting
    burst.greenSpeed		=+1.0;		// shifting
    burst.lifetime			= 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate			= 400;
    spark.velocity			= 125;
    spark.emissionRange		= 2* M_PI;	// 360 deg
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 3;
    
    spark.contents			= (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.25;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
}

@end
