//
//  StoryViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/12/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "StoryViewController.h"
#import <BuiltIO/BuiltIO.h>

@interface StoryViewController ()
@property (strong, nonatomic) NSDictionary *storyData;
@property (strong, nonatomic) NSArray *pages;
@property (nonatomic) int currentPageIndex;
@property (nonatomic) int numberOfPages;
@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(PerformAction:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft ;
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(PerformAction:)];
    right.direction = UISwipeGestureRecognizerDirectionRight ;
    [self.view addGestureRecognizer:right];
    _currentPageIndex = 0;
    [self builtLoadStory];
}

- (void)builtLoadStory
{
    BuiltQuery *query = [BuiltQuery queryWithClassUID:@"book"];
    
    [query whereKey:@"uid"
            equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"book_uid"]];
    [query exec:^(QueryResult *result, ResponseType type) {
        // the query has executed successfully.
        // [result getResult] will contain a list of objects that satisfy the conditions
        NSLog(@"%@", [result getResult]);
        _storyData = [[result getResult] objectAtIndex:0];
        _pages = [_storyData objectForKey:@"pages"];
        _numberOfPages = (int) [_pages count];
        [self updateStory];
    } onError:^(NSError *error, ResponseType type) {
        // query execution failed.
        // error.userinfo contains more details regarding the same
        NSLog(@"%@", error.userInfo);
    }];
}

- (void)updateStory
{
    NSString *text = [_pages objectAtIndex:_currentPageIndex];
    [_titleLabel setText:[_storyData objectForKey:@"title"]];
    [_textLabel setText:text];
    [_currentLabel setText:[NSString stringWithFormat:@"%d", _currentPageIndex + 1]];
    [_numberOfPagesLabel setText:[NSString stringWithFormat:@"%d", _numberOfPages]];
    
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

- (void)swipeRight {
    if (_currentPageIndex == 0) {
        NSLog(@"no. At first page");
        return;
    }
        
    _currentPageIndex -= 1;
    [self updateStory];
}

- (void)swipeLeft {
    if (_currentPageIndex == _numberOfPages - 1) {
        NSLog(@"no. at last page");
        return;
    }
    
    _currentPageIndex += 1;
    [self updateStory];
}

-(void)PerformAction:(UISwipeGestureRecognizer *)sender {
    if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"RIGHT GESTURE");
        [self swipeRight];
    }
    
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"LEFT GESTURE");
        [self swipeLeft];
    }
}

@end
