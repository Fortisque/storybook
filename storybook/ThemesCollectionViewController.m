//
//  BubbleThemesCollectionViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/21/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "ThemesCollectionViewController.h"
#import "BubblesCollectionViewCell.h"

@interface ThemesCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSTimer *myTimer;
@property (strong, nonatomic) NSArray *finalData;
@end

@implementation ThemesCollectionViewController

static NSString * const reuseIdentifier = @"Bubbles";

- (void)viewDidLoad {
    [super viewDidLoad];
        
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    UINib *cellNib = [UINib nibWithNibName:@"BubblesCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
    
    _tableData = [[NSMutableArray alloc] init];
    
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
    
    _finalData = themes;
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self
                                              selector: @selector(addCell) userInfo: nil repeats: YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) addCell {
    NSUInteger index = [_tableData count];
    if (index == [_finalData count]) {
        [_myTimer invalidate];
        return;
    }
    [self.collectionView performBatchUpdates:^{
        [_tableData addObject:[_finalData objectAtIndex:index]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    } completion:nil];
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
}x
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_tableData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BubblesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == NULL) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BubblesCollectionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleUp.fromValue  = [NSValue valueWithCGSize:CGSizeMake(0.0f, 0.0f)];
    scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)];
    scaleUp.springBounciness = 20.0f;
    scaleUp.springSpeed = 20.0f;
    
    [cell.layer pop_addAnimation:scaleUp forKey:@"first"];
    
    // Configure the cell
    NSDictionary *data = [_tableData objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [data objectForKey:kText];
    cell.backgroundImage.image = [UIImage imageNamed:[data objectForKey:kImageName]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO pass theme information
    [self performSegueWithIdentifier:@"selected_theme" sender:self.parentViewController];
}

//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor greenColor];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:(102.0/255.0) green:(204.0/255.0) blue:(255.0/255.0) alpha:1.0];
//}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 30, 50, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30;
}

@end
