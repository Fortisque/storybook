//
//  UnscrambleWordsViewController.m
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "UnscramblePageViewController.h"
#import "TileView.h"
#import "TileContainerView.h"
#import <pop/POP.h>

@interface UnscramblePageViewController ()

@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSArray *scenes;
@property (strong, nonatomic) NSMutableArray *answer;
@property (strong, nonatomic) NSMutableArray *containers; //array of TileContainerView
@property (strong, nonatomic) NSMutableArray *tiles;

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation UnscramblePageViewController

const int TILE_TAG= 1;
const int TILE_CONTAINER_TAG = 2;

const int SCREEN_WIDTH = 1024;
const int MAX_SPACING = 80;
const int PADDING = 50;
const int CONTAINER_SIZE = 110;
const int TILE_SIZE = 100;

- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews andWord:(NSString *)word {
    self = [super initWithTextLabels:textLabels andImageViews:imageViews];
    if (self) {
        _word = word;
    }
    return self;
}

- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews andScenes:(NSArray *)scenes {
    self = [super initWithTextLabels:textLabels andImageViews:imageViews];
    if (self) {
        _scenes = scenes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_word) {
        [self addTileContainersWithSize:(int)_word.length];
        //[self addLetterTiles];
        NSArray *propertiesArray = [self createPropertiesArrayForWord:_word];
        [self addTilesWithPropertiesArray:propertiesArray toView:self.view];
        
    }
    if (_scenes) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 2)];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2.3, self.view.frame.size.height / 2);
        [self.view addSubview:_scrollView];
        
        [self addTileContainersWithSize:5];
        NSArray *propertiesArray = [self createPropertiesArrayForScenes:_scenes];
        [self addTilesWithPropertiesArray:propertiesArray toView:_scrollView];
    }
    [self applyGesureRecognizer];
}

//- (void) viewDidAppear:(BOOL)animated {
//    [self addTiles];
//    [self applyGesureRecognizer];
//}
//
//- (void) viewDidDisappear:(BOOL)animated {
//    for (UIView * view in self.view.subviews) {
//        view.gestureRecognizers = nil;
//        [view removeFromSuperview];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTileContainersWithSize:(int)size {
    _containers = [[NSMutableArray alloc] init];
    
    int maxContainerSpace = CONTAINER_SIZE + MAX_SPACING;
    int spaceContainersCanOccupy = SCREEN_WIDTH - 2 * PADDING;
    int spaceForEachContainer = spaceContainersCanOccupy/size; //container plus padding space
    int startingPostion;
    
    if (spaceForEachContainer > maxContainerSpace) {
        //NSLog(@"need to reudce spacing from %d to %d", spaceForEachContainer, maxContainerSpace);
        spaceForEachContainer = maxContainerSpace;
        
        int totalContainerSpace = size * CONTAINER_SIZE + (size - 1) * MAX_SPACING; //n-1 spacing
        int padding = (SCREEN_WIDTH - totalContainerSpace)/2; //left and right padding outside containers
        startingPostion = padding + CONTAINER_SIZE/2; //recalculate padding and add container center offset
        
    } else {
        int paddingForEachContainer = (spaceForEachContainer - CONTAINER_SIZE)/2; //left or right padding
        startingPostion = PADDING + paddingForEachContainer + CONTAINER_SIZE/2; //add half of container size for center offset
    }
    
    for (int i = 0; i < size; i++) {
        TileContainerView *tileContainer;
        
        if (_word) {
            tileContainer = [[TileContainerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        }
        
        if (_scenes) {
            tileContainer = [[TileContainerView alloc] initWithFrame:CGRectMake(0, 0, 180, 150)];

        }
    
        tileContainer.center = CGPointMake(startingPostion + i*spaceForEachContainer, 250);
        //NSLog(@"tileContainer frame: %@", NSStringFromCGPoint(tileContainer.center));
        
        tileContainer.tag = TILE_CONTAINER_TAG;
        [_containers addObject:tileContainer];
        [self.view addSubview:tileContainer];
    }
}

- (void)addTilesWithPropertiesArray:(NSArray *)propertiesArray toView:(UIView *)view {
    _tiles = [[NSMutableArray alloc] init];
    
    for (int i=0; i < [propertiesArray count]; i++) {
        NSDictionary *properties = [propertiesArray objectAtIndex:i];
        TileView *tileView = [[TileView alloc] initWithProperties:properties];
        [_tiles addObject:tileView];
        [view addSubview:tileView];
    }
}

- (NSMutableArray *)createPropertiesArrayForWord:(NSString *)word {
    NSMutableArray *propertiesArray = [NSMutableArray array];
    
    //get all characters
    _answer = [NSMutableArray array];
    NSMutableArray *characters = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_word length]; i++) {
        NSString *character = [_word substringWithRange:NSMakeRange(i, 1)];
        [characters addObject:character];
        [_answer addObject:character];
    }
    
    //keep shuffling characters until the word is no longer the same
    while ([_word isEqualToString:[self getScrambledTileWordFromCharacters:characters]]) {
        for (int i = 0; i < characters.count*2; i++) { //shuffle many times
            int randomInt1 = arc4random() % [characters count];
            int randomInt2 = arc4random() % [characters count];
            [characters exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
        }
    }
    
    //always evenly split tiles regardless of spacing
    int size = (int) _word.length;
    int spaceTilesCanOccupy = SCREEN_WIDTH - 2 * PADDING;
    int spaceForEachTile = spaceTilesCanOccupy/size; //tile plus padding space
    int paddingForEachTile = (spaceForEachTile - TILE_SIZE)/2; //left or right padding
    int startingPostion = PADDING + paddingForEachTile + TILE_SIZE/2; //add half of tile size for center offset
    
    NSValue *frame = [NSValue valueWithCGRect:CGRectMake(0,0,100,100)];
    
    for (int i = 0; i < [characters count]; i++) {
        NSString *character = [characters objectAtIndex:i];
        NSDictionary *properties = @{
                                     kFrame:frame,
                                     @"letter":character,
                                     kCenter:[NSValue valueWithCGPoint:CGPointMake(startingPostion + i*spaceForEachTile, 600)],
                                     kTag:[NSNumber numberWithInt:TILE_TAG]
                                     };
        [propertiesArray addObject:properties];
    }
    return propertiesArray;
}

- (NSMutableArray *)createPropertiesArrayForScenes:(NSArray *)scenes {
    NSMutableArray *propertiesArray = [NSMutableArray array];
    
    //get the plot.
    _answer = [NSMutableArray array];
    for (int i = 0; i < [_scenes count]; i++) {
        NSDictionary *scene = [_scenes objectAtIndex:i];
        [_answer addObject:[scene objectForKey:@"sentence"]];
    }

    NSMutableArray *copy = [_scenes mutableCopy];
    
    //keep shuffling tiles until order of the scenes is no longer the same
    while ([_scenes isEqualToArray:copy]) {
        for (int i = 0; i < copy.count*2; i++) { //shuffle many times
            int randomInt1 = arc4random() % [copy count];
            int randomInt2 = arc4random() % [copy count];
            [copy exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
        }
    }
    
    //always evenly split tiles regardless of spacing
    int size = 5;
    int spaceTilesCanOccupy = SCREEN_WIDTH - 2 * PADDING;
    int spaceForEachTile = spaceTilesCanOccupy/size; //tile plus padding space
    int paddingForEachTile = (spaceForEachTile - TILE_SIZE)/2; //left or right padding
    int startingPostion = PADDING + paddingForEachTile + TILE_SIZE/2; //add half of tile size for center offset
    
    NSValue *frame = [NSValue valueWithCGRect:CGRectMake(0,0,400,266)];

    for (int i = 0; i < [copy count]; i++) {
        NSDictionary *scene = [copy objectAtIndex:i];
        NSDictionary *properties = @{
                                     kFrame:frame,
                                     kImageName:[scene objectForKey:kImageName],
                                     @"sentence":[scene objectForKey:@"sentence"],
                                     kCenter:[NSValue valueWithCGPoint:CGPointMake(startingPostion + 100 + i*(spaceForEachTile + 250), 200)],
                                     kTag:[NSNumber numberWithInt:TILE_TAG]
                                     };
        TileView *tileView = [[TileView alloc] initWithProperties:properties];
        [_tiles addObject:tileView];
        [_scrollView addSubview:tileView];
    }
    
    return propertiesArray;
}

- (void)applyGesureRecognizer {
    NSArray *arrToSearchForTiles;
    
    if (_scrollView) {
        arrToSearchForTiles = _scrollView.subviews;
    } else {
        arrToSearchForTiles = self.view.subviews;
    }
    
    for (UIView * view in arrToSearchForTiles) {
        if (view.tag == TILE_TAG) {
            //simple drag
            UIPanGestureRecognizer * recognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            recognizer1.delegate = self;
            [view addGestureRecognizer:recognizer1];
        }
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    TileView *tv = (TileView *) recognizer.view;

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"dragging tile %@", tv.text);
        
        TileContainerView *container = [_containers firstObject];
        
        // Scale image to the container, 5 px padding on all sides
        NSUInteger width = container.frame.size.width - 10;
        NSUInteger height = container.frame.size.height - 10;
        
        if (_scrollView) {
            // swap views if it's in a scroll view
            [tv setCenter:[recognizer locationInView:self.view]];
            [self.view addSubview:tv];
            
            // compress more for scroll view so it fits in film image
            height = container.frame.size.height - 50;
        }
        
        // make sure object is at original size before attempting transformation
        tv.transform = CGAffineTransformIdentity;
        
        POPSpringAnimation *scaleDown = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];

        scaleDown.toValue = [NSValue valueWithCGSize:CGSizeMake(width / tv.frame.size.width, height / tv.frame.size.height)];
        scaleDown.springBounciness = 10.0f;
        scaleDown.springSpeed = 20.0f;
        [tv pop_addAnimation:scaleDown forKey:@"down"];
        
        //reset tile and container if moved out of container
        for (TileContainerView *containerView in _containers) {
            if (containerView.containedTile == recognizer.view) {
                ((TileView *)recognizer.view).matched = NO;
                containerView.containedTile = nil;
                containerView.containedText = @"";
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        //check if tile is dragged near a container
        [self checkIfTileMatchesAnyContainer:recognizer.view];
        
        if (((TileView *)recognizer.view).matched) {
            //keep position
            
        } else {
            //animate tile back to original position
            if (_scrollView) {
                // get back into the scroll view
                [tv setCenter:[recognizer locationInView:_scrollView]];
                [_scrollView addSubview:tv];
            }
            
            [self animateView:recognizer.view ToPosition:((TileView *)recognizer.view).originalPosition];
            POPSpringAnimation *scaleUp = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            scaleUp.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
            scaleUp.springBounciness = 20.0f;
            scaleUp.springSpeed = 20.0f;
            
            [tv pop_addAnimation:scaleUp forKey:@"original"];
        }
        
        
        NSMutableArray *result = [self getResult];
        NSLog(@"actual%@", _answer);
        if ([result isEqualToArray:_answer]) {
            [_scrollView removeFromSuperview];
            [Animations congratulateInView:self.view];
        }
    }
}

- (void)checkIfTileMatchesAnyContainer:(UIView *)view {
    TileView *currentTileView = (TileView *)view;
    
    for (TileContainerView *containerView in _containers) {
        
        if ([self view1:currentTileView isCloseToView2:containerView]) { //if close enough to be contained
            
            if (containerView.containedTile) { //if container already has a tile: swap
                
                //animate tile in container back to original position
                [self animateView:containerView.containedTile ToPosition:containerView.containedTile.originalPosition];
                
                //update matched bool
                containerView.containedTile.matched = NO;
                currentTileView.matched = YES;
                
                //assign new tile to container
                containerView.containedTile = currentTileView;
                containerView.containedText = currentTileView.text;
                
            } else {  //else set the containedTile to the currently dragged tile
                
                //update matched bool
                currentTileView.matched = YES;
                
                //assign new tile to container
                containerView.containedTile = currentTileView;
                containerView.containedText = currentTileView.text;
            }
            
            //animate to center of container
            [self animateView:containerView.containedTile ToPosition:containerView.center];
        }
    }
}

- (BOOL)view1:(UIView *)view1 isCloseToView2:(UIView *)view2 {
    int xDiff = abs(view1.center.x - view2.center.x);
    int yDiff = abs(view1.center.y - view2.center.y);
    if ((xDiff < 50) && (yDiff < 50)) {
        return YES;
    }
    return NO;
}


- (void)animateView:(UIView *)view ToPosition:(CGPoint) position {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         view.center = position;
                     }
                     completion:^(BOOL finished) {}];
}

- (NSMutableArray *)getResult {
    NSMutableArray *result = [NSMutableArray array];
    for (TileContainerView *containerView in _containers) {
        [result addObject:containerView.containedText];
    }
    NSLog(@"result scene: %@", result);
    return result;
}

- (NSString *)getScrambledTileWordFromCharacters:(NSMutableArray *)characters {
    NSString *result = [[NSString alloc]init];
    for (NSString *character in characters) {
        result = [result stringByAppendingString:character];
    }
    return result;
}

@end
