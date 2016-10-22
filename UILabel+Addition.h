//
//  UILabel+Addition.h
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

+ (UILabel *)add_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize;


+ (UILabel *)add_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textHexColor:(uint32_t)hex;

@end
