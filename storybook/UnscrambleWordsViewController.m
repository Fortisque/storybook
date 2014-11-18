//
//  UnscrambleWordsViewController.m
//  storybook
//
//  Created by Gavin Chu on 11/17/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "UnscrambleWordsViewController.h"
#import "DragAndDropUIGestureRecognizer.h"

@interface UnscrambleWordsViewController ()

@end

@implementation UnscrambleWordsViewController

const int TILE_TAG_1 = 1;
const int TILE_TAG_2 = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Frame: %@", NSStringFromCGRect(self.view.bounds));
    [self addTiles];
    [self applyGesureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addTiles {
    NSLog(@"AddTiles");
    TileView *tile1View = [[TileView alloc] initWithLetter:@"A"];
    TileView *tile2View = [[TileView alloc] initWithLetter:@"T"];
    TileView *tile3View = [[TileView alloc] initWithLetter:@"C"];
    
    tile1View.center = CGPointMake(150, 500);
    tile2View.center = CGPointMake(275, 500);
    tile3View.center = CGPointMake(400, 500);
    
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
        }else if(view.tag == TILE_TAG_2){
            //custom gesture recognizer
            DragAndDropUIGestureRecognizer *recognizer2 = [[DragAndDropUIGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:) andStartingPosition:view.center];
            
            recognizer2.delegate = self;
            [view addGestureRecognizer:recognizer2];
        }
    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}

@end
