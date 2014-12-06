//
//  ThemeStoriesCollectionViewController.m
//  storybook
//
//  Created by Gavin Chu on 11/25/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemeStoriesCollectionViewController.h"
#import "StoryCollectionViewCell.h"
#import "ThemeDetailViewController.h"

@interface ThemeStoriesCollectionViewController ()

@property (strong, nonatomic) NSArray* bookImages;

@end

@implementation ThemeStoriesCollectionViewController

static NSString * const reuseIdentifier = @"StoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[StoryCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.books = [[NSMutableArray alloc]init];
    NSDictionary *book1 = @{@"title": @"Starter"};
    NSDictionary *book2 = @{@"title": @"Test"};
    NSDictionary *book3 = @{@"title": @"Test"};
    NSDictionary *book4 = @{@"title": @"Test"};
    NSDictionary *book5 = @{@"title": @"Test"};
    NSDictionary *book6 = @{@"title": @"Test"};
    NSDictionary *book7 = @{@"title": @"Test"};
    NSDictionary *book8 = @{@"title": @"Test"};
    NSDictionary *book9 = @{@"title": @"Test"};
    
    [self.books addObject:book1];
    [self.books addObject:book2];
    [self.books addObject:book3];
    [self.books addObject:book4];
    [self.books addObject:book5];
    [self.books addObject:book6];
    [self.books addObject:book7];
    [self.books addObject:book8];
    [self.books addObject:book9];
    
    //fake book images for now
    self.bookImages = @[@"bookpurple", @"bookgreen", @"bookblue", @"bookorange"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.books count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *bookImageName = self.bookImages[indexPath.row % [self.bookImages count]];
    [cell.bookImage setImage:[UIImage imageNamed:bookImageName]];
    return cell;
}

- (void)incrementIndex{
    if (self.currentIndex < [self.books count] - 3) {
        self.currentIndex++;
    }
}

- (void)decrementIndex{
    if (self.currentIndex > 0) {
        self.currentIndex--;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //pass book information
    [((ThemeDetailViewController *)self.parentViewController)loadBookDetailTitle:@"Tom the Chipmunk and Nature’s Strangers"Author:@"Author: Elijah Alpern" Illustrator:@"Illustrator: Sasha Zamani" BookCover:@"chipmunk" Description:@"This short story brings you on an adventure through the forest. Follow Tom, a chipmunk as he works with his friends to make sense of his world"];
    
    //Open book detail view
    [((ThemeDetailViewController *)self.parentViewController)openBookDetailView];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Close book detail view
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int minIndex = 100;
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        if ((int)indexPath.row < minIndex) {
            minIndex = (int)indexPath.row;
        }
    }
    self.currentIndex = minIndex;
}

#pragma mark – UICollectionViewDelegateFlowLayout

const int BOOK_PADDING = 50; //left and right padding
const int BOOK_SPACING = 40; //space between books

//setting book cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = self.view.frame.size.width;
    float bookWidth = width - (BOOK_PADDING * 2);
    float bookHeight = bookWidth * 1.3;
    CGSize bookCellSize = CGSizeMake(bookWidth, bookHeight);
    return bookCellSize;
}

//setting section border size
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, BOOK_PADDING, 10, BOOK_PADDING);
}

//setting spacing between books
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return BOOK_SPACING;
}

@end
