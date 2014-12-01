//
//  ThemeDetailViewController.m
//  storybook
//
//  Created by Gavin Chu on 11/25/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemeDetailViewController.h"

@interface ThemeDetailViewController ()

@end

@implementation ThemeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookDetailOpened = NO;
    self.bookDetailView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)populateThemeView {
    
}

- (void)populateStoriesCollectionView {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"embedStoriesCollectionView"]) {
        self.collectionViewController = (ThemeStoriesCollectionViewController *) [segue destinationViewController];
    } else if ([segue.identifier isEqualToString:@"embedBookDetail"]) {
        self.bookDetailViewController = (BookDetailViewController *) [segue destinationViewController];
    }
}

- (IBAction)upArrowClicked:(UIButton *)sender {
    [self.collectionViewController decrementIndex];
    [self.collectionViewController.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionViewController.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:YES];
}

- (IBAction)downArrowClicked:(UIButton *)sender {
    [self.collectionViewController incrementIndex];
    [self.collectionViewController.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionViewController.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:YES];
}

- (IBAction)themeViewTouched:(UITapGestureRecognizer *)sender {
    [self closeBookDetailView];
}

- (void)openBookDetailView {
    self.bookDetailView.hidden = NO;
    if (self.bookDetailOpened) {
        
    } else {
        self.bookDetailView.frame = CGRectMake(self.view.frame.size.width, 0, self.bookDetailView.frame.size.width, self.bookDetailView.frame.size.height);// somewhere offscreen
        [UIView animateWithDuration:0.6
                         animations:^{
                             float width = self.view.frame.size.width - self.storiesCollectionView.frame.size.width - self.bookDetailView.frame.size.width;
                             self.bookDetailView.frame = CGRectMake(width, 0, self.bookDetailView.frame.size.width, self.bookDetailView.frame.size.height);// its final location
                         }];
        self.bookDetailOpened = YES;
    }
    
}

- (void)closeBookDetailView {
    [UIView animateWithDuration:0.8
                     animations:^{
                         self.bookDetailView.frame = CGRectMake(self.view.frame.size.width, 0, self.bookDetailView.frame.size.width, self.bookDetailView.frame.size.height);// its final location
                     }];
    self.bookDetailOpened = NO;
}

- (void)loadBookDetailTitle:(NSString *)title
                     Author:(NSString *)author
                  BookCover:(NSString *)imageName
                Description:(NSString *)description
                     Bought:(BOOL)bought {
    self.bookDetailViewController.bookTitle.text = title;
    self.bookDetailViewController.bookAuthor.text = author;
    self.bookDetailViewController.bookDescription.text = description;
    self.bookDetailViewController.bookImage.image = [UIImage imageNamed:imageName];
    self.bookDetailViewController.bought = bought;
}

@end
