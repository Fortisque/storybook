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
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat SCREEN_WIDTH = screenRect.size.width;
    CGFloat SCREEN_HEIGHT = screenRect.size.height;
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 150)];
    title.text = @"storybubbles";
    title.font = [UIFont fontWithName:@"Quicksand-BoldItalic" size:100];
    title.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:title];
    
    self.view.backgroundColor = [Helper colorWithHexString:@"00C7FF"];
    //[Animations spawnBubblesInView:self.view];
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

@end
