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
                             kImageName: @"first_page",
                             kFrame: @[@0,@0,@1,@1],
                             };
    NSDictionary *image2 = @{
                             kImageName: @"chipmunk",
                             kFrame: @[@0.4,@0.4,@0.3,@0.4]
                             };
    NSDictionary *image3 = @{
                             kImageName: @"character",
                             kFrame: @[@0.5,@0.4,@0.4,@0.4]
                             };
    NSDictionary *page1text1 = @{
                            kText: @"Down in the meadow where animals flocked.\r"
                            @"Were four flanky mammals, on two legs they walked!\r"
                            @"Creatures that young Tom had not seen before.\r"
                            @"The curious chipmunk just had to know more.",
                            kFontSize: @36.0f,
                            kFrame:@[@0.2,@0.65,@0,@0],
                            kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                            kBorder: @20,
                            };
    /*NSDictionary *page1text2 = @{
                            kText: @"He slid down the tree right down to the ground.\r"
                            @"Coughed up his nine acorns and bursted with sound.\r"
                            @"“I saw somethin’ weird, hurry up follow me!”\r"
                            @"The curious crew craved something to see.",
                            kFrame:@[@0.05,@0.5,@1,@0.4],
                            kFontSize: @25.0f,
                            };*/
    NSDictionary *page2text1 = @{
                            kText: @"They walked in a line, mostly following tracks,\r"
                            @"And carried strange things on these bags on their backs.\r"
                            @"The animals passed, and continued on through,\r"
                            @"And Tommy the chipmunk consulted his crew.",
                            kFrame:@[@0.05,@0.3,@1,@0.4],
                            kFontSize: @25.0f,
                            };
    NSDictionary *page3text1 = @{
                            kText: @"They rustled through brush as if in a rush,\r"
                            @"Popped out of the woods when Tom signaled shush!\r"
                            @"The beasts were right there, within a tree’s reach,\r"
                            @"They froze with amazement, were left without speech.\r",
                            kFrame:@[@0.05,@0.3,@1,@0.4],
                            kFontSize: @25.0f,
                            };
    
    NSDictionary *page4text1 = @{
                            kText: @"They rustled through brush as if in a rush,\r"
                            @"Popped out of the woods when Tom signaled shush!\r"
                            @"The beasts were right there, within a tree’s reach,\r"
                            @"They froze with amazement, were left without speech.\r",
                            kFrame:@[@0.05,@0.3,@1,@0.4],
                            kFontSize: @25.0f,
                            };
    
    NSDictionary *text4 = @{
                            kText: @"What color is Tom?",
                            kFrame:@[@0.4,@0.1,@1,@0.1],
                            kFontSize: @25.0f,
                            kFontName: @"Fredoka One"
                            };
    
    NSDictionary *text5 = @{
                            kText: @"What do you think the mammals look like?",
                            kFrame:@[@0.2,@0.1,@0.2,@0.1],
                            kFontSize: @30.0f,
                            kFontName: @"Fredoka One"
                            };
    
    NSDictionary *text6 = @{
                            kText: @"summarize the story",
                            kFrame:@[@0.4,@0.1,@1,@0.1],
                            kFontSize: @25.0f,
                            kFontName: @"Fredoka One"
                            };
    
    NSArray *images = @[image1];
    NSArray *texts = @[page1text1];
    NSArray *texts2 = @[page2text1];

    
    BasePageViewController *normalPageVC = [[BasePageViewController alloc] initWithTextLabels:texts andImageViews:images];
    
    BasePageViewController *normalPageVC2 = [[BasePageViewController alloc] initWithTextLabels:texts2 andImageViews:images];
    

    UnscramblePageViewController *unscrambleWordsVC = [[UnscramblePageViewController alloc] initWithTextLabels:@[text4] andImageViews:@[image2] andWord:@"BROWN"];
    
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
    
    self.vcs = [NSArray arrayWithObjects:normalPageVC, drawingPageVC, normalPageVC2, unscrambleWordsVC, unscrambleWordsVC2, nil];

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
