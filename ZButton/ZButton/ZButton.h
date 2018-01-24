//
//  ZButton.h
//  ZButton
//
//  Created by MQZHot on 18/01/24.
//  Copyright © 2018年 MQZHot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZButtonTypeImageTop,//图片在上
    ZButtonTypeTitleTop,//文字在上
    ZButtonTypeImageLeft,//图片在左
    ZButtonTypeTitleLeft//文字在左
} ZButtonType;

@class ZButton;
typedef void(^ActionBlock)(ZButton *weakBtn);

@interface ZButton : UIControl



/** 图片和文字排布样式 */
@property (nonatomic,assign) ZButtonType contentType;
/** 图片和文字间距 */
@property (nonatomic,assign) CGFloat space;
/** 图片大小 */
@property (nonatomic,assign) CGSize imageSize;
/** 正常状态下的图片 */
@property (nonatomic,strong) UIImage *imageNormal;
/** 选中状态的图片 */
@property (nonatomic,strong) UIImage *imageSelected;
/** 正常状态下的文字 */
@property (nonatomic,copy) NSString *titleNormal;
/** 选中状态的文字 */
@property (nonatomic,copy) NSString *titleSelected;
/** 正常状态下的文字颜色，默认黑色 */
@property (nonatomic,strong) UIColor *titleColorNormal;
/** 选中状态的文字颜色，默认黑色 */
@property (nonatomic,strong) UIColor *titleColorSelected;
/** 标题字体，默认15号系统字体 */
@property (nonatomic,strong) UIFont *titleFont;
/** 点击回调 */
@property (nonatomic,copy) ActionBlock actionBlock;

@end
