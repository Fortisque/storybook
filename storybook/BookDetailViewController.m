//
//  BookDetailViewController.m
//  storybook
//
//  Created by Gavin Chu on 12/1/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openBook:(UIButton *)sender {
    [self performSegueWithIdentifier:@"story" sender:self.parentViewController];
}

@end
