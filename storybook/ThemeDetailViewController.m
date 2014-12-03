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
    self.storiesCollectionView.hidden = YES;
    self.emptyWhiteView.hidden = YES;
    self.upArrow.hidden = YES;
    self.downArrow.hidden = YES;
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

- (IBAction)backButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)openStoriesCollectionView {
    //preset frame to right off the screen
    self.storiesCollectionView.frame = CGRectMake(self.view.frame.size.width, self.storiesCollectionView.frame.origin.y, self.storiesCollectionView.frame.size.width, self.storiesCollectionView.frame.size.height);
    self.emptyWhiteView.frame = CGRectMake(self.view.frame.size.width, self.emptyWhiteView.frame.origin.y, self.emptyWhiteView.frame.size.width, self.emptyWhiteView.frame.size.height);
    self.upArrow.frame = CGRectMake(self.view.frame.size.width, self.upArrow.frame.origin.y, self.upArrow.frame.size.width, self.upArrow.frame.size.height);
    self.downArrow.frame = CGRectMake(self.view.frame.size.width, self.downArrow.frame.origin.y, self.downArrow.frame.size.width, self.downArrow.frame.size.height);
    
    //slide in from right
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.storiesCollectionView.hidden = NO;
                         self.emptyWhiteView.hidden = NO;
                         self.upArrow.hidden = NO;
                         self.downArrow.hidden = NO;
                         
                         float width = self.view.frame.size.width - self.storiesCollectionView.frame.size.width;
                         self.storiesCollectionView.frame = CGRectMake(width, self.storiesCollectionView.frame.origin.y, self.storiesCollectionView.frame.size.width, self.storiesCollectionView.frame.size.height);
                         self.emptyWhiteView.frame = CGRectMake(width, self.emptyWhiteView.frame.origin.y, self.emptyWhiteView.frame.size.width, self.emptyWhiteView.frame.size.height);
                         self.upArrow.frame = CGRectMake(width, self.upArrow.frame.origin.y, self.upArrow.frame.size.width, self.upArrow.frame.size.height);
                         self.downArrow.frame = CGRectMake(width, self.downArrow.frame.origin.y, self.downArrow.frame.size.width, self.downArrow.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self showButtons];
                     }];
}

- (void)showButtons {
    self.backButton.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.shopButton.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         self.backButton.hidden = NO;
                         self.shopButton.hidden = NO;
                         
                         self.backButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.shopButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     }
                     completion:^(BOOL finished) {}];
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
                Description:(NSString *)description {
    self.bookDetailViewController.bookTitle.text = title;
    self.bookDetailViewController.bookAuthor.text = author;
    self.bookDetailViewController.bookDescription.text = description;
    self.bookDetailViewController.bookImage.image = [UIImage imageNamed:imageName];
}

@end
