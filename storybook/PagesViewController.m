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
    
    // Page 1 Assets - Story
    NSDictionary *page1background = @{
                                      kImageName: @"first_page",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    NSDictionary *page1text1 = @{
                                 kText: @"Down in the meadow where animals flocked.\r"
                                 @"Were four flanky mammals, on two legs they walked!\r"
                                 @"Creatures that young Tom had not seen before.\r"
                                 @"The curious chipmunk just had to know more.",
                                 kFontSize: @36.0f,
                                 kCenter:@[@0.55,@0.8],
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    BasePageViewController *normalPageVC = [[BasePageViewController alloc] initWithTextLabels:@[page1text1] andImageViews:@[page1background]];
    
    // Page 2 Assets - Unscramble Word
    NSDictionary *chipmunk = @{
                               kImageName: @"chipmunk",
                               kImageSize:[NSValue valueWithCGSize:CGSizeMake(0.3, 0.4)],
                               kCenter:@[@0.5,@0.36],
                               };
    NSDictionary *paperbackground = @{
                                      kImageName: @"paperdraw",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    NSDictionary *page2text = @{
                                kText: @"What color is Tom?",
                                kCenter:@[@0.5,@0.1],
                                kFontSize: @50.0f,
                                kFontName: @"Fredoka One"
                                };
    
     UnscramblePageViewController *unscrambleWordsVC = [[UnscramblePageViewController alloc] initWithTextLabels:@[page2text]
                                                                                                  andImageViews:@[paperbackground,chipmunk]
                                                                                                        andWord:@"BROWN"];
    
    // Page 3 Assets - Story
    NSDictionary *page3background = @{
                                      kImageName: @"first_page",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    NSDictionary *page3text1 = @{
                                 kText: @"They walked in a line, mostly following tracks,\r"
                                 @"And carried strange things on these bags on their backs.\r"
                                 @"The animals passed, and continued on through,\r"
                                 @"And Tommy the chipmunk consulted his crew.",
                                 kCenter:@[@0.5,@0.1],
                                 kFontSize: @20.0f,
                                 };
    
    BasePageViewController *normalPageVC2 = [[BasePageViewController alloc] initWithTextLabels:@[page3text1] andImageViews:@[page3background]];
    
    // Page 4 Assets - Draw
    NSDictionary *page4text = @{
                            kText: @"What do you think the mammals look like?",
                            kCenter:@[@0.5,@0.1],
                            kFontSize: @40.0f,
                            kFontName: @"Fredoka One"
                            };
    
    DrawingPrompterViewController *drawingPageVC = [[DrawingPrompterViewController alloc] initWithTextLabels:@[page4text] andImageViews:@[paperbackground]];
    
    // Page 5 Assets - Unscramble Scenes
    NSDictionary *filmstrip = @{
                                kImageName: @"filmstrip",
                                kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 0.3)],
                                kCenter:@[@0.5,@0.25],
                                };
    NSDictionary *page5text = @{
                            kText: @"Summarize the story",
                            kCenter:@[@0.5,@0.05],
                            kFontSize: @50.0f,
                            kFontName: @"Fredoka One"
                            };
    
    NSDictionary *scene1 = @{@"imageName":@"first_page",
                             @"sentence":@"Tom sees the mammals"};
    
    NSDictionary *scene2 = @{@"imageName":@"chipmunk",
                             @"sentence":@"and this"};
    
    NSDictionary *scene3 = @{@"imageName":@"first_page",
                             @"sentence":@"and then this"};
    
    NSDictionary *scene4 = @{@"imageName":@"character",
                             @"sentence":@"after this"};
    
    NSDictionary *scene5 = @{@"imageName":@"character",
                             @"sentence":@"finally this"};
    
    NSArray *scenes = @[scene1, scene2, scene3, scene4, scene5];
    
    UnscramblePageViewController *unscrambleWordsVC2 = [[UnscramblePageViewController alloc] initWithTextLabels:@[page5text]
                                                                                                  andImageViews:@[paperbackground,filmstrip]
                                                                                                      andScenes:scenes];
    
    /*NSDictionary *page1text2 = @{
                            kText: @"He slid down the tree right down to the ground.\r"
                            @"Coughed up his nine acorns and bursted with sound.\r"
                            @"“I saw somethin’ weird, hurry up follow me!”\r"
                            @"The curious crew craved something to see.",
                            kFrame:@[@0.05,@0.5,@1,@0.4],
                            kFontSize: @25.0f,
                            };*/
    
    /*NSDictionary *page3text1 = @{
                            kText: @"They rustled through brush as if in a rush,\r"
                            @"Popped out of the woods when Tom signaled shush!\r"
                            @"The beasts were right there, within a tree’s reach,\r"
                            @"They froze with amazement, were left without speech.\r",
                            kCenter:@[@0.5,@0.1],
                            kFontSize: @25.0f,
                            };
    
    NSDictionary *page4text1 = @{
                            kText: @"They rustled through brush as if in a rush,\r"
                            @"Popped out of the woods when Tom signaled shush!\r"
                            @"The beasts were right there, within a tree’s reach,\r"
                            @"They froze with amazement, were left without speech.\r",
                            kCenter:@[@0.5,@0.1],
                            kFontSize: @25.0f,
                            };
    */
    
    self.vcs = [NSArray arrayWithObjects:normalPageVC, unscrambleWordsVC, normalPageVC2, drawingPageVC, unscrambleWordsVC2, nil];

    NSArray *viewControllers = [NSArray arrayWithObjects:normalPageVC, nil];
    
    [self setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
    
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
