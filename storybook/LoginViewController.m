//
//  LoginViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/11/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "LoginViewController.h"
#import <BuiltIO/BuiltIO.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    BuiltUser *user = [BuiltUser user];
    
    [user loginWithEmail:_emailField.text
             andPassword:_passwordField.text
               OnSuccess:^{
                   // user has logged in successfully
                   [self performSegueWithIdentifier:@"success" sender:self];
                   [[NSUserDefaults standardUserDefaults] setObject:_emailField.text forKey:@"email"];
               } onError:^(NSError *error) {
                   // login failed
                   // error.userinfo contains more details regarding the same
                   NSLog(@"%@", error.userInfo);
                   _errorLabel.text = [error.userInfo valueForKey:@"error_message"];
               }];
}

- (IBAction)sign_up:(id)sender {
    BuiltUser *user = [BuiltUser user];
    user.email = _emailField.text;
    user.password = _passwordField.text;
    user.confirmPassword = _passwordField.text;
    [user signUpOnSuccess:^{
        _errorLabel.text = [NSString stringWithFormat:@"Yay, %@ is signed up!", user.email];
    } onError:^(NSError *error) {
        // there was an error in signing up the user
        // error.userinfo contains more details regarding the same
        NSLog(@"%@", error.userInfo);
        _errorLabel.text = [error.userInfo valueForKey:@"error_message"];
    }];
}

@end
