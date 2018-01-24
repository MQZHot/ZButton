//
//  ZButton.h
//  ZButton
//
//  Created by MQZHot on 18/01/24.
//  Copyright © 2018年 MQZHot. All rights reserved.
//

#import "ZButton.h"

#define WEAK_SELF __typeof(self) __weak weakSelf = self;

//字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//根据传入的文字、宽度和字体计算出合适的size (CGSize)
#define getAdjustSizeWith_text_width_font(text,width,font) ({[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:NULL].size;})

//根据传入的文字和字体获取宽度 (CGFloat)
#define getWidthWith_title_font(title,font) ({\
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];\
label.text = title;\
label.font = font;\
[label sizeToFit];\
label.frame.size.width;\
})

@interface ZButton ()

@property (nonatomic, assign) CGSize imageRectSize;
@property (nonatomic, assign) CGSize titleRectSize;
@property (nonatomic, assign) CGPoint imageOrigin;
@property (nonatomic, assign) CGPoint titleOrigin;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@end

@implementation ZButton

-(instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self initParams];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        [self initParams];
    }
    return self;
}
-(void)initParams {
    self.backgroundColor=[UIColor clearColor];
    self.titleFont=[UIFont systemFontOfSize:15];
    self.titleColor=[UIColor blackColor];
    self.contentType=ZButtonTypeImageLeft;
    self.space=0;
    self.layer.masksToBounds=YES;
}
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.actionBlock) {
        WEAK_SELF
        ActionBlock block=[self.actionBlock copy];
        block(weakSelf);
    } else {
        [super sendAction:action to:target forEvent:event];
    }
}

-(void)drawRect:(CGRect)rect {
    self.selected = self.selected;
    [self getTitleSizeWithRect:rect font:self.titleFont];
    [self getImageSizeWithRect:rect];
    [self getTitleOriginWithRect:rect];
    [self getImageOriginWithRect:rect];
    if (self.image) {
        [self.image drawInRect:CGRectMake(self.imageOrigin.x, self.imageOrigin.y,self.imageRectSize.width,self.imageRectSize.height)];
    }
    [self setTitleWithColor:self.titleColor];
}
-(void)setTitleWithColor:(UIColor *)color {
    if (self.title) {
        NSMutableDictionary *dict=[NSMutableDictionary new];
        dict[NSForegroundColorAttributeName]=color;
        dict[NSFontAttributeName]=self.titleFont;
        [self.title drawInRect:CGRectMake(self.titleOrigin.x, self.titleOrigin.y,self.titleRectSize.width,self.titleRectSize.height) withAttributes:dict];
    }
}

-(void)getImageOriginWithRect:(CGRect)rect {
    CGFloat imageX;
    CGFloat imageY;
    switch (self.contentType) {
        case ZButtonTypeImageLeft: {
            imageX=self.titleOrigin.x-self.space-self.imageRectSize.width;
            imageY=(rect.size.height-self.imageRectSize.height)*0.5;
        }
            break;
        case ZButtonTypeTitleLeft: {
            imageX=self.titleOrigin.x+self.space+self.titleRectSize.width;
            imageY=(rect.size.height-self.imageRectSize.height)*0.5;
        }
            break;
        case ZButtonTypeImageTop: {
            imageY=self.titleOrigin.y-self.imageRectSize.height-self.space;
            imageX=(rect.size.width-self.imageRectSize.width)*0.5;
        }
            break;
        case ZButtonTypeTitleTop: {
            imageY=self.titleOrigin.y+self.titleRectSize.height+self.space;
            imageX=(rect.size.width-self.imageRectSize.width)*0.5;
        }
            break;
        default: break;
    }
    self.imageOrigin=CGPointMake(imageX, imageY);
}
-(void)getTitleOriginWithRect:(CGRect)rect {
    CGFloat titleY;
    CGFloat titleX;
    switch (self.contentType) {
        case ZButtonTypeImageLeft: {
            titleX=(rect.size.width-self.titleRectSize.width-self.space-self.imageRectSize.width)*0.5+self.imageRectSize.width+self.space;
            titleY=(rect.size.height-self.titleRectSize.height)*0.5;
        }
            break;
        case ZButtonTypeTitleLeft: {
            titleX=(rect.size.width-self.titleRectSize.width-self.space-self.imageRectSize.width)*0.5;
            
            titleY=(rect.size.height-self.titleRectSize.height)*0.5;
        }
            break;
            
        case ZButtonTypeImageTop: {
            titleY=(rect.size.height-self.titleRectSize.height-self.imageRectSize.height-self.space)*0.5+self.imageRectSize.height+self.space;
            titleX=(rect.size.width-self.titleRectSize.width)*0.5;
        }
            break;
            
        case ZButtonTypeTitleTop: {
            titleY=(rect.size.height-self.titleRectSize.height-self.imageRectSize.height-self.space)*0.5;
            titleX=(rect.size.width-self.titleRectSize.width)*0.5;
        }
            break;
        default: break;
    }
    self.titleOrigin=CGPointMake(titleX, titleY);
}

//计算文字的size
-(void)getTitleSizeWithRect:(CGRect)rect font:(UIFont *)font {
    if (StringIsEmpty(self.title)==NO) {
        CGFloat textWith=getWidthWith_title_font(self.title, font);
        if (self.contentType==ZButtonTypeImageTop || self.contentType==ZButtonTypeTitleTop) {
            CGFloat rectW=rect.size.width;
            self.titleRectSize=getAdjustSizeWith_text_width_font(self.title, textWith>rectW?rectW:textWith, font);
        } else {
            CGFloat rectW=(rect.size.width-self.imageRectSize.width-self.space);
            self.titleRectSize=getAdjustSizeWith_text_width_font(self.title,  textWith>rectW?rectW:textWith, font);
        }
    }
}
//计算图片的size
-(void)getImageSizeWithRect:(CGRect)rect {
    if (self.image) {
        CGFloat imageHWScale=self.image.size.height/self.image.size.width;
        CGFloat imageW;
        CGFloat imageH;
        switch (self.contentType) {
            case ZButtonTypeImageTop: {
                imageW=rect.size.width;
                imageH=imageW*imageHWScale;
            }
                break;
            case ZButtonTypeTitleTop: {
                imageW=rect.size.width;
                imageH=imageW*imageHWScale;
            }
                break;
            case ZButtonTypeImageLeft: {
                imageH=rect.size.height;
                imageW=imageH/imageHWScale;
            }
                break;
            case ZButtonTypeTitleLeft: {
                imageH=rect.size.height;
                imageW=imageH/imageHWScale;
            }
                break;
            default: break;
        }
        if (self.imageSize.width==CGSizeZero.width && self.imageSize.height==CGSizeZero.height) {
            self.imageRectSize=CGSizeMake(imageW, imageH);
        } else {
            self.imageRectSize=self.imageSize;
        }
    }
}

#pragma mark - 方法重写
-(void)setSpace:(CGFloat)space {
    _space = space;
    [self setNeedsDisplay];
}
-(void)setTitle:(NSString *)title {
    _title=title;
    [self setNeedsDisplay];
}
-(void)setTitleFont:(UIFont *)titleFont {
    _titleFont=titleFont;
    [self setNeedsDisplay];
}
-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor=titleColor;
    [self setNeedsDisplay];
}
-(void)setImage:(UIImage *)image {
    _image=image;
    [self setNeedsDisplay];
}

-(void)setContentType:(ZButtonType)contentType {
    _contentType=contentType;
    [self setNeedsDisplay];
}
-(void)setImageSize:(CGSize)imageSize {
    _imageSize=imageSize;
    [self setNeedsDisplay];
}
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleColor=self.titleColorSelected?self.titleColorSelected:self.titleColorNormal;
        self.title=self.titleSelected?self.titleSelected:self.titleNormal;
        self.image=self.imageSelected?self.imageSelected:self.imageNormal;
    } else {
        self.titleColor=self.titleColorNormal?self.titleColorNormal:self.titleColorSelected;
        self.title=self.titleNormal?self.titleNormal:self.titleSelected;
        self.image=self.imageNormal?self.imageNormal:self.imageSelected;
    }
}
-(void)setTitleNormal:(NSString *)titleNormal {
    _titleNormal=titleNormal;
    self.title=titleNormal;
}
-(void)setTitleSelected:(NSString *)titleSelected {
    _titleSelected=titleSelected;
    self.title=titleSelected;
}
-(void)setTitleColorNormal:(UIColor *)titleColorNormal {
    _titleColorNormal=titleColorNormal;
    self.titleColor=titleColorNormal;
}
-(void)setTitleColorSelected:(UIColor *)titleColorSelected {
    _titleColorSelected=titleColorSelected;
    self.titleColor=titleColorSelected;
}
-(void)setImageNormal:(UIImage *)imageNormal {
    _imageNormal=imageNormal;
    self.image=imageNormal;
}
-(void)setImageSelected:(UIImage *)imageSelected {
    _imageSelected=imageSelected;
    self.image=imageSelected;
}

@end
