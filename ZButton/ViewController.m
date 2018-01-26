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
    button.imageNormal=[UIImage imageNamed:@"me_icon_indent"];
//    button.imageSelected = [UIImage imageNamed:@"me_icon_indent"];
    
    button.titleFont=[UIFont systemFontOfSize:12];
    button.titleSelected = @"查询历史";
    button.titleNormal = @"我的订单";
    button.selected = NO;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.actionBlock = ^(ZButton *weakBtn) {
        NSLog(@"1111");
        weakBtn.selected = !weakBtn.selected;
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [button.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20171109135437541.png"] placeholderImage:[UIImage imageNamed:@"me_icon_indent"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            button.imageNormal = image;
        }];
    });
    
}
-(void)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"---");
}


@end
