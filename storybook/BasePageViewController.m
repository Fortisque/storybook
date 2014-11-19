//
//  SampleViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "BasePageViewController.h"
@import AVFoundation;

@interface BasePageViewController ()
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@end

@implementation BasePageViewController

- (id)init {
    self = [super init];
    
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (id)initWithText:(NSString *)text andImageName:(NSString *) imageName {
    if (self != nil)
    {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 30)];
        _textLabel.text = text;
        
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        _imageView.frame = CGRectMake(500, 240, 200, 150);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_textLabel];
    [self.view addSubview:_imageView];
    
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
