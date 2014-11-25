//
//  PagesViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "PagesViewController.h"
#import "BasePageViewController.h"
#import "VoicePageViewController.h"
#import "DrawingPageViewController.h"
#import "UnscramblePageViewController.h"
#import "DrawingPrompterViewController.h"

@interface PagesViewController ()
@property (nonatomic, strong) NSArray *vcs;
@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    NSDictionary *image1 = @{
                             kImageName: @"chipmunk",
                             kFrame: @[@0.5,@0.1,@0.2,@0.2]
                             };
    NSDictionary *image2 = @{
                             kImageName: @"character",
                             kFrame: @[@0.5,@0.4,@0.2,@0.2]
                             };
    NSDictionary *image3 = @{
                             kImageName: @"character",
                             kFrame: @[@0.5,@0.4,@0.2,@0.2]
                             };
    NSDictionary *text1 = @{
                            kText: @"hello!",
                            kFontSize: @36.0f,
                            kFrame:@[@0.1,@0.1,@0.2,@0.1]
                            };
    NSDictionary *text2 = @{
                            kText: @"welcome to the best story youngster",
                            kFrame:@[@0.1,@0.4,@0.5,@0.1]
                            };
    NSDictionary *text3 = @{
                            kText: @"what happens next",
                            };
    
    NSDictionary *text4 = @{
                            kText: @"how do you spell this",
                            kFrame:@[@0,@0.1,@1,@0.1]
                            };
    
    NSDictionary *text5 = @{
                            kText: @"draw a cat",
                            kFrame:@[@0.1,@0.1,@0.2,@0.1]
                            };
    
    NSDictionary *text6 = @{
                            kText: @"summarize the story",
                            kFrame:@[@0,@0.1,@1,@0.1]
                            };
    
    NSArray *images = @[image1, image2];
    NSArray *texts = @[text1, text2];
    
    BasePageViewController *normalPageVC = [[BasePageViewController alloc] initWithTextLabels:texts andImageViews:images];
    

    UnscramblePageViewController *unscrambleWordsVC = [[UnscramblePageViewController alloc] initWithTextLabels:@[text4] andImageViews:nil andWord:@"CAT"];
    
    NSDictionary *scene1 = @{@"imageName":@"character",
                             @"sentence":@"first this"};
    
    NSDictionary *scene2 = @{@"imageName":@"character",
                             @"sentence":@"and this"};
    
    NSDictionary *scene3 = @{@"imageName":@"character",
                             @"sentence":@"and then this"};
    
    NSDictionary *scene4 = @{@"imageName":@"character",
                             @"sentence":@"after this"};
    
    NSDictionary *scene5 = @{@"imageName":@"character",
                             @"sentence":@"finally this"};
    
    NSArray *scenes = @[scene1, scene2, scene3, scene4, scene5];
    
    UnscramblePageViewController *unscrambleWordsVC2 = [[UnscramblePageViewController alloc] initWithTextLabels:@[text6] andImageViews:nil andScenes:scenes];
    
    DrawingPrompterViewController *drawingPageVC = [[DrawingPrompterViewController alloc] initWithTextLabels:@[text5] andImageViews:nil];
    
    self.vcs = [NSArray arrayWithObjects:normalPageVC, unscrambleWordsVC, unscrambleWordsVC2, drawingPageVC, nil];

    NSArray *viewControllers = [NSArray arrayWithObjects:normalPageVC, nil];
    
    [self setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];

    
    //[self didMoveToParentViewController:self];
    self.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
        
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    
    return [_vcs objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    NSUInteger newIndex = index + 1;
    
    if (newIndex == [_vcs count]) {
        return nil;
    }
    
    return [_vcs objectAtIndex:newIndex];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
