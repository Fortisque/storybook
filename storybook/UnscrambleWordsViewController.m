//
//  UnscrambleWordsViewController.m
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "UnscrambleWordsViewController.h"
#import "TileView.h"
#import "TileContainerView.h"

@interface UnscrambleWordsViewController ()

@property (strong, nonatomic) NSMutableArray *containers; //array of TileContainerView

@end

@implementation UnscrambleWordsViewController

const int TILE_TAG_1 = 1;
const int TILE_CONTAINER_TAG = 2;

const int TILE_TAG_2 = 3;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Frame: %@", NSStringFromCGRect(self.view.bounds));
    [self addTileContainersWithSize:3];
    [self addTiles];
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
    
    //TODO: get size of full width and distribute evenly
    //hard-coded location for now
    
    for(int i = 0; i < size; i++){
        TileContainerView *tileContainer = [[TileContainerView alloc] init];
        tileContainer.center = CGPointMake(140 + i*135, 250);
        NSLog(@"tileContainer frame: %@", NSStringFromCGPoint(tileContainer.center));
        tileContainer.tag = TILE_CONTAINER_TAG;
        [self.view addSubview:tileContainer];
        [self.containers addObject:tileContainer];
    }
}

- (void) addTiles {
    TileView *tile1View = [[TileView alloc] initWithLetter:@"A"];
    TileView *tile2View = [[TileView alloc] initWithLetter:@"T"];
    TileView *tile3View = [[TileView alloc] initWithLetter:@"C"];
    
    tile1View.center = CGPointMake(150, 500);
    tile2View.center = CGPointMake(275, 500);
    tile3View.center = CGPointMake(400, 500);
    
    tile1View.originalPosition = tile1View.center;
    tile2View.originalPosition = tile2View.center;
    tile3View.originalPosition = tile3View.center;
    
    tile1View.tag = TILE_TAG_1;
    tile2View.tag = TILE_TAG_1;
    tile3View.tag = TILE_TAG_1;
    
    [self.view addSubview:tile1View];
    [self.view addSubview:tile2View];
    [self.view addSubview:tile3View];
}

- (void) applyGesureRecognizer {
    for (UIView * view in self.view.subviews) {
        if(view.tag == TILE_TAG_1){
            //simple drag
            UIPanGestureRecognizer * recognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            recognizer1.delegate = self;
            [view addGestureRecognizer:recognizer1];
        }
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        NSLog(@"dragging tile %@", ((TileView *)recognizer.view).letter);
        
        //reset tile and container if moved out of container
        for(TileContainerView *containerView in self.containers){
            if(containerView.containedTile == recognizer.view){
                ((TileView *)recognizer.view).matched = NO;
                containerView.containedTile = nil;
                containerView.containedLetter = @"";
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
                containerView.containedLetter = currentTileView.letter;
                
            }else{  //else set the containedTile to the currently dragged tile
                
                //update matched bool
                currentTileView.matched = YES;
                
                //assign new tile to container
                containerView.containedTile = currentTileView;
                containerView.containedLetter = currentTileView.letter;
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
        result = [result stringByAppendingString:containerView.containedLetter];
    }
    NSLog(@"result: %@", result);
    return result;
}

@end
