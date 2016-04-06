//
//  AViewController.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/28.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "AViewController.h"
#import "MXAnimatedTransiton.h"


@implementation AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake( 50, 100, 100, 50);
    [button setTitle:@"dismiss返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(backVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}



- (void)backVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}






@end
