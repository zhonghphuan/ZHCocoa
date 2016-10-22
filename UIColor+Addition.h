//
//  UIColor+Addition.h
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)
+ (instancetype)add_colorWithHex:(uint32_t)hex;
+ (instancetype)add_colorWithR:(int)red G:(int)green B:(int)blue alpha:(float)alpha;
+ (instancetype)add_randomColor;
@end
