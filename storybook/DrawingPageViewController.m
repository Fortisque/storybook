//
//  DrawingPageViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/18/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "DrawingPageViewController.h"

@interface DrawingPageViewController ()

@end

@implementation DrawingPageViewController

CGRect workingFrame;

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    
    if (self != nil)
    {
        workingFrame = CGRectMake(0, 0, 600, 600);
        self.mainImage = [[UIImageView alloc] initWithFrame:workingFrame];
        
        UIGraphicsBeginImageContext(self.mainImage.frame.size);
        [image drawInRect:workingFrame];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Further initialization if needed
    }
    return self;
}

- (void)viewDidLoad {
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    workingFrame = CGRectMake(0, 0, 600, 600);
    
    self.tempDrawImage = [[UIImageView alloc] initWithFrame:workingFrame];
    
    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.tempDrawImage];
    
    

    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.mainImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.mainImage.layer setBorderWidth: 2.0];
    self.mainImage.frame = workingFrame;
    self.tempDrawImage.frame = workingFrame;
    
    NSArray *colors = [[NSArray alloc] initWithObjects:@"Black", @"Grey", @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Indigo", @"Violet", @"Erase", nil];
    
    int i;
    for (i = 0; i < [colors count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(colorPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[colors objectAtIndex:i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i * 60 + 10.0, 600.0, 60.0, 40.0);
        button.tag = i;
        [self.view addSubview:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(donePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    button.frame = CGRectMake(500.0, 50.0, 60.0, 40.0);
    button.tag = i;
    [self.view addSubview:button];
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

- (IBAction)colorPressed:(id)sender {
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            // Black
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            // Grey
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            // Red
            red = 209.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            // Orange
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 34.0/255.0;
            break;
        case 4:
            // Yellow
            red = 255.0/255.0;
            green = 218.0/255.0;
            blue = 33.0/255.0;
            break;
        case 5:
            // Green
            red = 51.0/255.0;
            green = 221.0/255.0;
            blue = 0/255.0;
            break;
        case 6:
            // Blue
            red = 17.0/255.0;
            green = 51.0/255.0;
            blue = 204.0/255.0;
            break;
        case 7:
            // Indigo
            red = 75.0/255.0;
            green = 0.0/255.0;
            blue = 130.0/255.0;
            break;
        case 8:
            // Violet
            red = 34.0/255.0;
            green = 0.0/255.0;
            blue = 102.0/255.0;
            break;
        case 9:
            // Erase
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            opacity = 1.0;
            break;
    }
}

- (IBAction)donePressed:(id)sender {    
    [_presenter updateCustomImage:self.mainImage.image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.mainImage];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mainImage];
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.tempDrawImage.image drawInRect:workingFrame];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.mainImage.frame.size);
        [self.tempDrawImage.image drawInRect:workingFrame];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:workingFrame blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:workingFrame blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

@end
