//
//  BubbleThemesViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/21/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@property (strong, nonatomic) NSTimer *myTimer;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat SCREEN_WIDTH = screenRect.size.width;
//    CGFloat SCREEN_HEIGHT = screenRect.size.height;
    
    self.titleLabel.font = [UIFont fontWithName:@"FredokaOne-Regular" size:100];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [Helper colorWithHexString:@"00C7FF"];
    //[Animations spawnBubblesInView:self.view];
    
    
    //configure carousel
    _carousel.type = iCarouselTypeWheel;
}

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    
    NSDictionary *theme1 = @{
                             kText: @"Space",
                             kImageName: @"spacecircle"
                             };
    NSDictionary *theme2 = @{
                             kText: @"Forest",
                             kImageName: @"forestcircle"
                             };
    NSDictionary *theme3 = @{
                             kText: @"Desert",
                             kImageName: @"desertcircle"
                             };
    
    NSArray *themes = @[theme1, theme2, theme3, theme1, theme2, theme3];
    
    _items = [[NSMutableArray alloc] initWithArray:themes];
    NSLog(@"%@", _items);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    NSLog(@"%@", _items);
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
            
        // Configure the cell
        NSDictionary *data = [_items objectAtIndex:index];
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        NSLog(@"%@", [data objectForKey:kImageName]);
        ((UIImageView *)view).image = [UIImage imageNamed:[data objectForKey:kImageName]];
        [view.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [view.layer setBorderWidth: 15.0];
        view.layer.cornerRadius = 150.0;

    }
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}

@end
