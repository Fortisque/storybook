//
//  VoicePageViewController.h
//  storybook
//
//  Created by Alice J. Liu on 2014-11-17.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BasePageViewController.h"

@interface VoicePageViewController : BasePageViewController
<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)recordAudio:(id)sender;
- (IBAction)playAudio:(id)sender;

@end
