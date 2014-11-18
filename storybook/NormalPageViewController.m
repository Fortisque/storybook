//
//  SampleViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "NormalPageViewController.h"
@import AVFoundation;

@interface NormalPageViewController ()
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@end

@implementation NormalPageViewController

NSString * _text;
NSString * _imageName;

- (id)init {
    self = [super initWithNibName:@"NormalPageViewController" bundle:nil];
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (id)initWithText:(NSString *)text andImageName:(NSString *) imageName {
    self = [super initWithNibName:@"NormalPageViewController" bundle:nil];
    if (self != nil)
    {
        _text = text;
        _imageName = imageName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_textLabel setText:_text];
    UIImage *image = [UIImage imageNamed: _imageName];
    [_imageView setImage:image];
    [self startSpeaking];
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

#pragma mark - Speech Management

- (void)speakNextUtterance
{
    AVSpeechUtterance *nextUtterance = [[AVSpeechUtterance alloc]
                                        initWithString:[_textLabel text]];
    [self.synthesizer speakUtterance:nextUtterance];
}


- (void)startSpeaking
{
    if (!self.synthesizer) {
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    
    [self speakNextUtterance];
}

@end
