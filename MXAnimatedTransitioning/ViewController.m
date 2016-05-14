//
//  ViewController.m
//  MXAnimatedTransitioning
//
//  Created by 谢鹏翔 on 16/3/28.
//  Copyright © 2016年 谢鹏翔. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"


@interface ViewController ()

@property (nonatomic, assign) CGRect imageRect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testUI1];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 100, 40);
    [button setTitle:@"present跳转" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
}

- (void)testUI1
{
    _imageRect = CGRectMake(100, 150, 200, 200);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_imageRect];
    imageView.image = [UIImage imageNamed:@"ic_G3_kuaisudoujiang"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
}

- (void)testUI2
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *left_upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    left_upView.backgroundColor = [UIColor redColor];
    [self.view addSubview:left_upView];
    
    UIView *left_downView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    left_downView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:left_downView];
    
    UIView *right_upView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    right_upView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:right_upView];
    
    UIView *right_downView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    right_downView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:right_downView];
}

- (void)nextVC
{
    AViewController *aVC = [AViewController new];
    aVC.MXType = MXAnimatedSegueTypeScale;
    aVC.imageRect = _imageRect;
    [self presentViewController:aVC animated:YES completion:nil];
//    [self.navigationController pushViewController:aVC animated:YES];
}

- (void)dealloc
{
    NSLog(@"-------------- dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
