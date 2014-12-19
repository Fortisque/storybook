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
#import <BuiltIO/BuiltIO.h>

@interface PagesViewController ()
@property (nonatomic, strong) NSMutableArray *vcs;
@property (nonatomic, strong) NSArray *pages;
@end

@implementation PagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    BuiltQuery *storyQuery = [BuiltQuery queryWithClassUID:@"story"];
    [storyQuery whereKey:@"title" equalTo:self.title];
    
//    [storyQuery exec:^(QueryResult *result, ResponseType type) {
//        NSLog(@"%@", [[[result getResult] objectAtIndex:0] objectForKey:@"assets"]);
//    } onError:^(NSError *error, ResponseType type) {
//        // query execution failed.
//        // error.userinfo contains more details regarding the same
//        NSLog(@"%@", error.userInfo);
//    }];
    
    BuiltQuery *pagesQuery = [BuiltQuery queryWithClassUID:@"page"];
    [pagesQuery inQuery:storyQuery forKey:@"story"];
    [pagesQuery orderByAscending:@"number"];
    
    self.vcs = [NSMutableArray array];
    
    [pagesQuery exec:^(QueryResult *result, ResponseType type) {
        // the query has executed successfully.
        // [result getResult] will contain a list of objects that satisfy the conditions
        // here's the object we just created
        _pages = [result getResult];
        if ([_pages count] == 0) {
            [[self navigationController] popViewControllerAnimated:YES];
            NSLog(@"Can't find that book");
            return;
        }
        NSString *stringData;
        NSDictionary *jsonPageData;
        BasePageViewController *tmpVC;
        
        for (NSDictionary *page in _pages) {
            stringData = [page objectForKey:@"data"];
            jsonPageData = [NSJSONSerialization JSONObjectWithData: [stringData dataUsingEncoding:NSUTF8StringEncoding]
                                                           options: NSJSONReadingMutableContainers
                                                             error: NULL];
            NSLog(@"%@", jsonPageData);
            
            
            NSArray *textLabels = [jsonPageData objectForKey:@"text_labels"];
            NSArray *imageLabels = [jsonPageData objectForKey:@"image_labels"];
            
            NSString *className = [jsonPageData objectForKey:@"type"];
            NSString *word = [jsonPageData objectForKey:@"word"];
            NSArray *scenes = [jsonPageData objectForKey:@"scenes"];
            Class class = NSClassFromString(className);
            if (word != NULL){
                tmpVC = [[class alloc] initWithTextLabels:textLabels andImageViews:imageLabels andWord:word];
            } else if (scenes != NULL) {
                tmpVC = [[class alloc] initWithTextLabels:textLabels andImageViews:imageLabels andScenes:scenes];
            } else {
                tmpVC = [[class alloc] initWithTextLabels:textLabels andImageViews:imageLabels];
            }
            
            [self.vcs addObject:tmpVC];
        }
        
        NSArray *viewControllers = [NSArray arrayWithObjects:[self.vcs objectAtIndex:0], nil];
        
        [self setViewControllers:viewControllers
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:nil];
        
        self.dataSource = self;
    } onError:^(NSError *error, ResponseType type) {
        // query execution failed.
        // error.userinfo contains more details regarding the same
        NSLog(@"%@", error.userInfo);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
        
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    if (index == 0) {
        [[self navigationController] popViewControllerAnimated:YES];
        return nil;
    }
    
    return [_vcs objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [_vcs indexOfObject:viewController];
    
    NSUInteger newIndex = index + 1;
    
    if (newIndex == [_vcs count]) {
        // Clashes with summary page draggin.
        //[[self navigationController] popViewControllerAnimated:NO];
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
