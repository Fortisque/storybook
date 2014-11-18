//
//  PagesViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "PagesViewController.h"
#import "NormalPageViewController.h"
#import "SampleTwoViewController.h"
#import "UnscrambleWordsViewController.h"

@interface PagesViewController ()
@property (nonatomic, strong) NSArray *vcs;
@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"load");
    
    NormalPageViewController *dataViewController = [[NormalPageViewController alloc] initWithNibName:@"NormalPageViewController" bundle:nil];
    
    SampleTwoViewController *s2vc = [[SampleTwoViewController alloc] initWithNibName:@"SampleTwoViewController" bundle:nil];
    
    UnscrambleWordsViewController *unscrambleWordsVC = [[UnscrambleWordsViewController alloc] initWithNibName:@"UnscrambleWordsViewController" bundle:nil];
    
    _vcs = [NSArray arrayWithObjects:dataViewController, s2vc, unscrambleWordsVC, nil];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:dataViewController, nil];
    
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
    
    NSLog(@"before");
    
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    
    
    return [_vcs objectAtIndex:index - 1];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSLog(@"after");
    
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
