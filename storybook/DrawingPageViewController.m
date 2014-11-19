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

- (id)init {
    self = [super initWithNibName:@"DrawingPageViewController" bundle:nil];
    
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
}

- (IBAction)eraserPressed:(id)sender {
}
@end
