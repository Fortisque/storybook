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

@interface UnscramblePageViewController ()

@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSArray *scenes;
@property (strong, nonatomic) NSMutableArray *containers; //array of TileContainerView
@property (strong, nonatomic) NSMutableArray *tiles;

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
    if(self){
        self.word = word;
    }
    return self;
}

- (id)initWithTextLabels:(NSArray *)textLabels andImageViews:(NSArray *) imageViews andScenes:(NSArray *)scenes {
    self = [super initWithTextLabels:textLabels andImageViews:imageViews];
    if(self){
        self.scenes = scenes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.word) {
        [self addTileContainersWithSize:(int)self.word.length];
        [self addLetterTiles];
    }
    if (self.scenes) {
        [self addTileContainersWithSize:5];
        [self addSceneTiles];
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

- (void) addTileContainersWithSize:(int)size {
    self.containers = [[NSMutableArray alloc] init];
    
    int maxContainerSpace = CONTAINER_SIZE + MAX_SPACING;
    
    int spaceContainersCanOccupy = SCREEN_WIDTH - 2 * PADDING;
    int spaceForEachContainer = spaceContainersCanOccupy/size; //container plus padding space
    
    int startingPostion;
    
    if(spaceForEachContainer > maxContainerSpace){
        //NSLog(@"need to reudce spacing from %d to %d", spaceForEachContainer, maxContainerSpace);
        spaceForEachContainer = maxContainerSpace;
        
        int totalContainerSpace = size * CONTAINER_SIZE + (size - 1) * MAX_SPACING; //n-1 spacing
        int padding = (SCREEN_WIDTH - totalContainerSpace)/2; //left and right padding outside containers
        startingPostion = padding + CONTAINER_SIZE/2; //recalculate padding and add container center offset
        
    }else{
        int paddingForEachContainer = (spaceForEachContainer - CONTAINER_SIZE)/2; //left or right padding
        startingPostion = PADDING + paddingForEachContainer + CONTAINER_SIZE/2; //add half of container size for center offset
    }
    
    for(int i = 0; i < size; i++){
        TileContainerView *tileContainer = [[TileContainerView alloc] init];
        
        tileContainer.center = CGPointMake(startingPostion + i*spaceForEachContainer, 450);
        //NSLog(@"tileContainer frame: %@", NSStringFromCGPoint(tileContainer.center));
        
        tileContainer.tag = TILE_CONTAINER_TAG;
        [self.containers addObject:tileContainer];
        [self.view addSubview:tileContainer];
    }
}

- (void) addLetterTiles {
    self.tiles = [[NSMutableArray alloc] init];
    
    //get all characters
    NSMutableArray *characters = [[NSMutableArray alloc] init];
    for(int i = 0; i < [self.word length]; i++){
        NSString *character = [self.word substringWithRange:NSMakeRange(i, 1)];
        [characters addObject:character];
    }
    
    //keep shuffling characters/tiles until the word is no longer the same
    while([self.word isEqualToString:[self getScrambledTileWordFromCharacters:characters]]){
        for(int i = 0; i < characters.count*2; i++) { //shuffle many times
            int randomInt1 = arc4random() % [characters count];
            int randomInt2 = arc4random() % [characters count];
            [characters exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
        }
    }
    
    //always evenly split tiles regardless of spacing
    int size = (int) self.word.length;
    int spaceTilesCanOccupy = SCREEN_WIDTH - 2 * PADDING;
    int spaceForEachTile = spaceTilesCanOccupy/size; //tile plus padding space
    int paddingForEachTile = (spaceForEachTile - TILE_SIZE)/2; //left or right padding
    int startingPostion = PADDING + paddingForEachTile + TILE_SIZE/2; //add half of tile size for center offset
    
    NSValue *frame = [NSValue valueWithCGRect:CGRectMake(0,0,100,100)];
    
    //display the tiles
    for(int i = 0; i < [characters count]; i++){
        NSString *character = [characters objectAtIndex:i];
        NSDictionary *properties = @{
                                     @"frame":frame,
                                     @"letter":character
                                         };
        TileView *tileView = [[TileView alloc] initWithProperties:properties];
        tileView.center = CGPointMake(startingPostion + i*spaceForEachTile, 600);
        tileView.originalPosition = tileView.center;
        tileView.tag = TILE_TAG;
        [self.tiles addObject:tileView];
        [self.view addSubview:tileView];
    }
}

- (void) addSceneTiles {
    self.tiles = [[NSMutableArray alloc] init];
    
    NSMutableArray *copy = [_scenes mutableCopy];
    
    NSLog(@"%@", copy);
    
    while([_scenes isEqualToArray:copy]){
        for(int i = 0; i < copy.count*2; i++) { //shuffle many times
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
    
    NSValue *frame = [NSValue valueWithCGRect:CGRectMake(0,0,300,200)];
    
    //display the tiles
    for(int i = 0; i < [copy count]; i++){
        NSDictionary *scene = [copy objectAtIndex:i];
        NSDictionary *properties = @{
                                     @"frame":frame,
                                     @"imageName":[scene objectForKey:@"imageName"],
                                     @"sentence":[scene objectForKey:@"sentence"]
                                     };
        TileView *tileView = [[TileView alloc] initWithProperties:properties];
        tileView.center = CGPointMake(startingPostion + i*spaceForEachTile, 600);
        tileView.originalPosition = tileView.center;
        tileView.tag = TILE_TAG;
        [self.tiles addObject:tileView];
        [self.view addSubview:tileView];
    }
}

- (void) applyGesureRecognizer {
    for (UIView * view in self.view.subviews) {
        if(view.tag == TILE_TAG){
            //simple drag
            UIPanGestureRecognizer * recognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            recognizer1.delegate = self;
            [view addGestureRecognizer:recognizer1];
        }
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        NSLog(@"dragging tile %@", ((TileView *)recognizer.view).text);
        
        //reset tile and container if moved out of container
        for(TileContainerView *containerView in self.containers){
            if(containerView.containedTile == recognizer.view){
                ((TileView *)recognizer.view).matched = NO;
                containerView.containedTile = nil;
                containerView.containedText = @"";
            }
        }
    }
    else if(recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [recognizer translationInView:self.view];
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             recognizer.view.center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded){
        //check if tile is dragged near a container
        [self checkIfTileMatchesAnyContainer:recognizer.view];
        
        if(((TileView *)recognizer.view).matched){
            //keep position
            
        }else{
            //animate tile back to original position
            [self animateView:recognizer.view ToPosition:((TileView *)recognizer.view).originalPosition];
        }
        
        [self getUnscrambledWord];
    }
}

- (void)checkIfTileMatchesAnyContainer:(UIView *)view {
    TileView *currentTileView = (TileView *)view;
    
    for(TileContainerView *containerView in self.containers){
        
        if([self view1:currentTileView isCloseToView2:containerView]){ //if close enough to be contained
            
            if(containerView.containedTile){ //if container already has a tile: swap
                
                //animate tile in container back to original position
                [self animateView:containerView.containedTile ToPosition:containerView.containedTile.originalPosition];
                
                //update matched bool
                containerView.containedTile.matched = NO;
                currentTileView.matched = YES;
                
                //assign new tile to container
                containerView.containedTile = currentTileView;
                containerView.containedText = currentTileView.text;
                
            }else{  //else set the containedTile to the currently dragged tile
                
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
    if((xDiff < 50) && (yDiff < 50)){
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

- (NSString *)getUnscrambledWord {
    NSString *result = [[NSString alloc]init];
    for(TileContainerView *containerView in self.containers){
        result = [result stringByAppendingString:containerView.containedText];
    }
    NSLog(@"result: %@", result);
    return result;
}

- (NSString *)getScrambledTileWordFromCharacters:(NSMutableArray *)characters {
    NSString *result = [[NSString alloc]init];
    for(NSString *character in characters){
        result = [result stringByAppendingString:character];
    }
    return result;
}

@end
