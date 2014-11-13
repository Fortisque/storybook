//
//  LoginViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/11/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
- (IBAction)login:(id)sender;
- (IBAction)sign_up:(id)sender;

@end

