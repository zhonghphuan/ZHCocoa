//
//  UILabel+Addition.m
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import "UILabel+Addition.h"
#import "UIColor+Addition.h"
@implementation UILabel (Addition)

+ (UILabel *)add_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize{
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

+ (UILabel *)add_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textHexColor:(uint32_t)hex{
    UILabel *label = [self add_labelWithText:text fontSize:fontSize];
    label.textColor = [UIColor add_colorWithHex:hex];
    return label;
}
@end
