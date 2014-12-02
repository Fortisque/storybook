//
//  Helper.h
//  storybook
//
//  Created by Alice J. Liu on 2014-11-26.
//  Copyright (c) 2014 ieor190. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex andAlpha:(float)alpha;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (void)reassignFrameSizeToMinimumEnclosingSize:(UILabel *)label;

@end
