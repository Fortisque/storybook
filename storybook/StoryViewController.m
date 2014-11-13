//
//  StoryViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/12/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "StoryViewController.h"
#import <BuiltIO/BuiltIO.h>
#import "GRMustache.h"

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
    [_titleLabel setText:[_storyData objectForKey:@"title"]];
    [_numberOfPagesLabel setText:[NSString stringWithFormat:@"%d", _numberOfPages]];
    [_currentLabel setText:[NSString stringWithFormat:@"%d", _currentPageIndex + 1]];
    [self updateText];
}

- (void)updateText
{
    NSString *text = [_pages objectAtIndex:_currentPageIndex];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<% .* %>)" options:NSRegularExpressionCaseInsensitive error:NULL];
    NSTextCheckingResult *newSearchString = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    NSString *match = [text substringWithRange:newSearchString.range];
    
    NSDictionary *retrievedDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_values"];
    [_sampleTextField setHidden:YES];
    if ([match length] != 0) {
        text = [text stringByReplacingCharactersInRange:newSearchString.range withString:@""];
        NSString *data = [match substringWithRange:NSMakeRange(3, [match length] - 6)];
        NSArray *tmp = [data componentsSeparatedByString:@", "];
        NSString *action = [tmp objectAtIndex:0];
        NSString *value = [tmp objectAtIndex:1];
        if ([action isEqual: @"set_color"]) {
            [self.view setBackgroundColor:[self giveColorfromStringColor:[retrievedDictionary objectForKey:value]]];
        } else if ([action isEqual: @"text_field"]) {
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"current_question"];
            [_sampleTextField setHidden:NO];
        }
    }
    
    NSString *rendering = [GRMustacheTemplate renderObject:retrievedDictionary fromString:text error:NULL];
    
    
    [_textLabel setText:rendering];
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

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"end");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSMutableDictionary *retrievedDictionary = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_values"] mutableCopy];
    
    if (!retrievedDictionary) {
        retrievedDictionary = [[NSMutableDictionary alloc] init];
    }
    NSString *question = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_question"];
    NSString *answer = textField.text;
    
    [retrievedDictionary setObject:answer forKey:question];
    
    [[NSUserDefaults standardUserDefaults] setObject:retrievedDictionary forKey:@"user_values"];
    [self swipeLeft];
    textField.text = @"";
    return YES;
}

-(UIColor *)giveColorfromStringColor:(NSString *)colorname
{
    NSString *result = [NSString stringWithFormat:@"%@Color", colorname];
    SEL labelColor = NSSelectorFromString(result);
    UIColor *color = [UIColor performSelector:labelColor];
    return color;
}

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
        [self swipeRight];
    }
    
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self swipeLeft];
    }
}

@end
