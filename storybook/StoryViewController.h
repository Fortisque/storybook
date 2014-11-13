//
//  StoryViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/12/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPagesLabel;
@property (strong, nonatomic) IBOutlet UITextField *sampleTextField;

@end
