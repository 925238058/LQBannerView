//
//  ViewController.m
//  LQBannerScroll
//
//  Created by zhengliqiang on 2017/11/6.
//  Copyright © 2017年 zhengliqiang. All rights reserved.
//

#import "ViewController.h"

#import "LQBannerScroll.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    直接在这里调用就可以了
    LQBannerScroll *a  = [[LQBannerScroll alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.width*9/16)];
    [self.view addSubview:a];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
