//
//  SampleViewController.h
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalPageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithText:(NSString *)text andImageName:(NSString *) imageName;

@end
