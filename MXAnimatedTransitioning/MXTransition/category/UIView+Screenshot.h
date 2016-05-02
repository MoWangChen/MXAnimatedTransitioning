//
//  UIView+Screenshot.h
//  testScreenShot
//
//  Created by 谢鹏翔 on 16/5/2.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)

- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;

@end
