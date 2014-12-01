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
    if (self.bought) {
        [self performSegueWithIdentifier:@"story" sender:self.parentViewController];
    } else {
        //buy book, change text from price to "Read"
        NSString *text = @"Read";
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
        NSInteger _stringLength = [text length];
        UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, _stringLength)];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
        
        [self.readButton setAttributedTitle:attString forState:UIControlStateNormal];
        self.bought = YES;
    }
}



@end
