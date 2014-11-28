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
        self.collectionView = (ThemeStoriesCollectionViewController *) [segue destinationViewController];
    }
}

- (IBAction)upArrowClicked:(UIButton *)sender {
    [self.collectionView decrementIndex];
    [self.collectionView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:YES];
}

- (IBAction)downArrowClicked:(UIButton *)sender {
    [self.collectionView incrementIndex];
    [self.collectionView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.collectionView.currentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:YES];
}
@end
