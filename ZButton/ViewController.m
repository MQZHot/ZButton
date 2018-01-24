//
//  ViewController.m
//  ZButton
//
//  Created by mengqingzheng on 2018/1/24.
//  Copyright © 2018年 MQZHot. All rights reserved.
//

#import "ViewController.h"
#import "ZButton.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZButton *button = [[ZButton alloc]init];
    button.frame=CGRectMake(100, 100, 120, 120);
    button.backgroundColor=[UIColor orangeColor];
    button.contentType= ZButtonTypeImageTop;
    button.imageSize = CGSizeMake(40, 38);
    button.space=15;
    button.imageNormal=[UIImage imageNamed:@"me_icon_record"];
    button.imageSelected = [UIImage imageNamed:@"me_icon_indent"];
    button.titleNormal = @"我的订单";
    button.titleFont=[UIFont systemFontOfSize:12];
    button.titleSelected = @"查询历史";
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
