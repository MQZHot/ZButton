//
//  ViewController.m
//  ZButton
//
//  Created by mengqingzheng on 2018/1/24.
//  Copyright © 2018年 MQZHot. All rights reserved.
//

#import "ViewController.h"
#import "ZButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZButton *button = [[ZButton alloc]init];
    button.frame=CGRectMake(100, 100, 120, 120);
    button.backgroundColor=[UIColor orangeColor];
    button.contentType= ZButtonTypeImageTop;
    button.imageSize = CGSizeMake(62, 64);
    button.space=15;
    button.imageNormal=[UIImage imageNamed:@"4"];
    button.imageSelected = [UIImage imageNamed:@"3"];
    button.titleNormal = @"图上文下居中";
    button.titleFont=[UIFont systemFontOfSize:12];
    button.titleSelected = @"xxxxx";
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.actionBlock = ^(ZButton *weakBtn) {
        NSLog(@"1111");
        weakBtn.selected = !weakBtn.selected;
    };
}
-(void)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"---");
}


@end
