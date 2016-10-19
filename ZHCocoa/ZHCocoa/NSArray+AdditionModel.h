//
//  NSArray+AdditionModel.h
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AdditionModel)

+ (instancetype)add_arrayWithClassName:(NSString *)className plistName:(NSString *)plistName;
+ (instancetype)add_arrayWithArrayClassName:(NSString *)className plistName:(NSString *)plistName;
+ (instancetype)add_arrayWithArrayAndDictRootClassName:(NSString *)RootclassName className:(NSString *)className  plistName:(NSString *)plistName;

+ (instancetype)add_arrayWithArrayAndDictRootClassName:(NSString *)RootclassName className:(NSString *)className  jsonName:(NSString *)jsonName;
@end
