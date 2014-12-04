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
    
    // Page 1 Assets - Draw
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
                                 kCenter:@[@0.5,@0.8],
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    NSDictionary *page1text2 = @{
                                kText: @"What do you think the two-legged mammals look like?",
                                kCenter:@[@0.5,@0.1],
                                kFontSize: @40.0f,
                                kFontName: @"Fredoka One"
                                };
    

    
    DrawingPrompterViewController *drawingPageVC = [[DrawingPrompterViewController alloc] initWithTextLabels:@[page1text1] andImageViews:@[page1background]];
    
    // Page 2 Assets - Story
    NSDictionary *page2background = @{
                                      kImageName: @"second_page",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    NSDictionary *page2text1 = @{
                                 kText: @"He slid down the tree right down to the ground.\r"
                                 @"Coughed up his nine acorns and bursted with sound.\r"
                                 @"“I saw somethin’ weird, hurry up follow me!”\r"
                                 @"The curious crew craved something to see.",
                                 kCenter:@[@0.5,@0.8],
                                 kFontSize: @36.0f,
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    BasePageViewController *normalPageVC = [[BasePageViewController alloc] initWithTextLabels:@[page2text1] andImageViews:@[page2background]];
    
    // Page 3 Assets - Unscramble Word
    NSDictionary *chipmunk = @{
                               kImageName: @"chipmunk",
                               kImageSize:[NSValue valueWithCGSize:CGSizeMake(0.3, 0.4)],
                               kCenter:@[@0.5,@0.36],
                               };
    NSDictionary *paperbackground = @{
                                      kImageName: @"paperdraw",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    NSDictionary *page3text = @{
                                kText: @"What color is Tom?",
                                kCenter:@[@0.5,@0.1],
                                kFontSize: @50.0f,
                                kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.5],
                                kBorder: @20,
                                kFontName: @"Fredoka One"
                                };
    
    UnscramblePageViewController *unscrambleWordsVC = [[UnscramblePageViewController alloc] initWithTextLabels:@[page3text]
                                                                                                  andImageViews:@[page2background]
                                                                                                        andWord:@"BROWN"];
    
    // Page 4 Assets - Story
    NSDictionary *page4background = @{
                                      kImageName: @"third_page",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };

    
    NSDictionary *page4text1 = @{
                                 kText: @"They rustled through brush as if in a rush,\r"
                                 @"Popped out of the woods when Tom signaled shush!\r"
                                 @"The beasts were right there, within a tree’s reach,\r"
                                 @"They froze with amazement, were left without speech.",
                                 kCenter:@[@0.45,@0.15],
                                 kFontSize: @30.0f,
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    NSDictionary *page4text2 = @{
                                 kText: @"They walked in a line, mostly following tracks,\r"
                                 @"And carried strange things on these bags on their backs.",
                                 kCenter:@[@0.55,@0.85],
                                 kFontSize: @30.0f,
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    BasePageViewController *normalPageVC2 = [[BasePageViewController alloc] initWithTextLabels:@[page4text1, page4text2] andImageViews:@[page4background]];
    
    // Page 5 Assets - Story
    NSDictionary *page5background = @{
                                      kImageName: @"fourth_page",
                                      kImageSize:[NSValue valueWithCGSize:CGSizeMake(1, 1)],
                                      };
    
    NSDictionary *page5text1 = @{
                                 kText: @"The animals passed, and continued on through,\r"
                                 @"And Tommy the chipmunk consulted his crew.\r"
                                 @"Roxy the Rabbit thought they were smart bears.\r"
                                 @"Banjo the Badger just gave back blank stares.",
                                 kCenter:@[@0.6,@0.85],
                                 kFontSize: @30.0f,
                                 kTextBackgroundColor: [Helper colorWithHexString:@"FFFFFF" andAlpha:0.8],
                                 kBorder: @20,
                                 };
    
    BasePageViewController *normalPageVC3 = [[BasePageViewController alloc] initWithTextLabels:@[page5text1] andImageViews:@[page5background]];

    
    // Page 6 Assets - Unscramble Scenes
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
                             @"sentence":@"Tom discovers the mammals"};
    
    NSDictionary *scene2 = @{@"imageName":@"second_page",
                             @"sentence":@"Tom slides down the tree"};
    
    NSDictionary *scene3 = @{@"imageName":@"third_page",
                             @"sentence":@"Tom sees the beasts close up"};
    
    NSDictionary *scene4 = @{@"imageName":@"fourth_page",
                             @"sentence":@"Tom consults the crew"};
    
    NSDictionary *scene5 = @{@"imageName":@"character",
                             @"sentence":@"finally this"};
    
    NSArray *scenes = @[scene1, scene2, scene3, scene4, scene5];
    
    UnscramblePageViewController *unscrambleWordsVC2 = [[UnscramblePageViewController alloc] initWithTextLabels:@[page5text]
                                                                                                  andImageViews:@[paperbackground,filmstrip]
                                                                                                      andScenes:scenes];
    
    self.vcs = [NSArray arrayWithObjects:drawingPageVC, normalPageVC, unscrambleWordsVC, normalPageVC2, normalPageVC3, unscrambleWordsVC2, nil];

    NSArray *viewControllers = [NSArray arrayWithObjects:drawingPageVC, nil];
    
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
