//
//  UIColor+Addition.m
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)
+ (instancetype)add_colorWithHex:(uint32_t)hex{
    int red   = (hex & 0xFF0000) >> 16;
    int green = (hex & 0x00FF00) >> 8;
    int blue  = (hex & 0x0000FF);
    
    return [UIColor add_colorWithR:red G:green B:blue alpha:1];
}
+ (instancetype)add_colorWithR:(int)red G:(int)green B:(int)blue alpha:(float)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (instancetype)add_randomColor{
    return [UIColor add_colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256) alpha:1];
}
@end
