//
//  DrawingPrompterViewController.m
//  storybook
//
//  Created by Kevin Casey on 11/18/14.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import "DrawingPageViewController.h"
#import "DrawingPrompterViewController.h"

@interface DrawingPrompterViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DrawingPrompterViewController
@synthesize imageView;

bool firstLoad = true;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    [imageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [imageView.layer setBorderWidth: 2.0];
    
    imageView.frame = CGRectMake(300, 100, 400, 400);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(promptDrawing)];
    
    imageView.userInteractionEnabled = YES; // allow taps on image.
    [imageView addGestureRecognizer:singleTap];
    
    [self.view addSubview:imageView];
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (firstLoad == true) {
        firstLoad = false;
        [self promptDrawing];
    }
    
}

- (void)promptDrawing
{
    DrawingPageViewController *dpvc = [[DrawingPageViewController alloc] initWithNibName:@"DrawingPageViewController" bundle:nil];
    
    dpvc.presenter = self;
    
    [self presentViewController:dpvc animated:YES completion:^{
        NSLog(@"Complete");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCustomImage:(UIImage *)image {
    [imageView setImage:image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
