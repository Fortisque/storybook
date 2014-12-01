//
//  ThemeViewController.m
//  storybook
//
//  Created by Gavin Chu on 12/1/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeDetailViewController.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)themeViewTouched:(UITapGestureRecognizer *)sender {
    [(ThemeDetailViewController *)self.parentViewController closeBookDetailView];
}

@end
