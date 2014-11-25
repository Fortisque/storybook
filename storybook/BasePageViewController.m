//
//  SampleViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "BasePageViewController.h"
#import <pop/POP.h>
@import AVFoundation;

@interface BasePageViewController ()  <AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *textLabels;
@property (strong, nonatomic) NSMutableArray *imageViews;
@property (strong, nonatomic) NSMutableArray *utterances;
@property (nonatomic, assign) NSUInteger nextSpeechIndex;

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

- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews {
    self = [super init];

    if (self != nil)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat SCREEN_WIDTH = screenRect.size.width;
        CGFloat SCREEN_HEIGHT = screenRect.size.height;
        
        _textLabels = [[NSMutableArray alloc] init];
        _imageViews = [[NSMutableArray alloc] init];
        _utterances = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [textLabels count]; i++) {
            
            NSDictionary *textDict = [textLabels objectAtIndex:i];
            UILabel *textLabel;
            NSArray *frameValue = [textDict objectForKey:kFrame];
            if (frameValue) {
                CGFloat x = [[frameValue objectAtIndex:0] floatValue] * SCREEN_WIDTH;
                CGFloat y = [[frameValue objectAtIndex:1] floatValue] * SCREEN_HEIGHT;
                CGFloat width = [[frameValue objectAtIndex:2] floatValue] * SCREEN_WIDTH;
                CGFloat height = [[frameValue objectAtIndex:3] floatValue] * SCREEN_HEIGHT;

                textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
            } else {
                textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
            }
            
            NSString *fontName = [textDict objectForKey:kFontName];
            NSNumber *fontSize = [textDict objectForKey:kFontSize];
            
            if (fontName && fontSize) {
                textLabel.font = [UIFont fontWithName:fontName size:[fontSize floatValue]];
            } else if (fontName) {
                textLabel.font = [UIFont fontWithName:fontName size:16.0f];
            } else if (fontSize) {
                textLabel.font = [UIFont fontWithName:@"Gill Sans" size:[fontSize floatValue]];
            }
            textLabel.text = [textDict objectForKey:kText];
            textLabel.textAlignment = NSTextAlignmentCenter;
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
            tapGestureRecognizer.numberOfTapsRequired = 1;
            [textLabel addGestureRecognizer:tapGestureRecognizer];
            textLabel.userInteractionEnabled = YES;
            [_textLabels addObject:textLabel];
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:textLabel.text];
            utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
            //[utterance setValuesForKeysWithDictionary:utteranceProperties];
            [_utterances addObject:utterance];
        }
        
        for (int i = 0; i < [imageViews count]; i++) {
            NSDictionary *imageDict = [imageViews objectAtIndex:i];

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageDict objectForKey:kImageName]]];
            NSArray *frameValue = [imageDict objectForKey:kFrame];
            if (frameValue) {
                CGFloat x = [[frameValue objectAtIndex:0] floatValue] * SCREEN_WIDTH;
                CGFloat y = [[frameValue objectAtIndex:1] floatValue] * SCREEN_HEIGHT;
                CGFloat width = [[frameValue objectAtIndex:2] floatValue] * SCREEN_WIDTH;
                CGFloat height = [[frameValue objectAtIndex:3] floatValue] * SCREEN_HEIGHT;
                
                imageView.frame = CGRectMake(x, y, width, height);
            } else {
                imageView.frame = CGRectMake(300, 100, 400, 100);
            }

            [_imageViews addObject:imageView];
        }
        
        self.nextSpeechIndex = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_textLabel];
    [self.view addSubview:_imageView];
    
    for (int i = 0; i < [_textLabels count]; i++) {
        [self.view addSubview:[_textLabels objectAtIndex:i]];
    }
    
    for (int i = 0; i < [_imageViews count]; i++) {
        [self.view addSubview:[_imageViews objectAtIndex:i]];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.nextSpeechIndex = 0;
    [self startSpeaking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)labelTapped:(UIGestureRecognizer *) gestureRecognizer {
     UILabel *tappedLabel = (UILabel*) [gestureRecognizer.view hitTest:[gestureRecognizer locationInView:gestureRecognizer.view] withEvent:nil];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:[tappedLabel text]];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    
    AVSpeechSynthesizer *speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    speechSynthesizer.delegate = self;
    [speechSynthesizer speakUtterance:utterance];
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
    if (self.nextSpeechIndex < [_utterances count]) {
        AVSpeechUtterance *utterance = [_utterances objectAtIndex:self.nextSpeechIndex];
        self.nextSpeechIndex += 1;
        
        [self.synthesizer speakUtterance:utterance];
    }
}


- (void)startSpeaking
{
    if (!self.synthesizer) {
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
        self.synthesizer.delegate = self;
    }
    
    [self speakNextUtterance];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSString *s = utterance.speechString;
    
    [self expandTextFor:s];
}

- (void)expandTextFor:(NSString *)s
{
    UILabel *l = [self labelForString:s];
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.5f, 1.5f)];
    scaleUp.springBounciness = 1.0f;
    scaleUp.springSpeed = 20.0f;
    
    [l.layer pop_addAnimation:scaleUp forKey:@"first"];
}

- (void)unexpandTextFor:(NSString *)s
{
    UILabel *l = [self labelForString:s];
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.fromValue  = [NSValue valueWithCGSize:CGSizeMake(1.5f, 1.5f)];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleUp.springBounciness = 1.0f;
    scaleUp.springSpeed = 20.0f;
    
    [l.layer pop_addAnimation:scaleUp forKey:@"second"];
}

- (UILabel *)labelForString:(NSString *)s
{
    for (int i = 0; i < [_textLabels count]; i++) {
        UILabel *l = [_textLabels objectAtIndex:i];
        if (l.text == s) {
            return l;
        }
    }
    return nil;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance
{
    NSUInteger indexOfUtterance = [_utterances indexOfObject:utterance];
    [self unexpandTextFor:utterance.speechString];
    if (indexOfUtterance == NSNotFound) {
        return;
    }
    
    [self speakNextUtterance];
}

@end
