//
//  NSArray+AdditionModel.h
//  zhonghuan-类扩展
//
//  Created by zhonghuan.
//  Copyright © 2016年 zhonghuan. All rights reserved.
//

#import "NSArray+AdditionModel.h"

@implementation NSArray (AdditionModel)

/**
 *  @brief 数组(root)[字典1,字典2,字典3......]
 *
 *  @param className 模型类名
 *  @param plistName plist文件名
 *
 *  @return 返回模型数组
 */
+ (instancetype)add_arrayWithClassName:(NSString *)className plistName:(NSString *)plistName {

    //获取文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    //读取文件
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    //字典转模型
    NSMutableArray *tempArray = [NSMutableArray array];

    for (NSDictionary *dict in array) {

        Class clz  = NSClassFromString(className);
        NSObject * model = [[clz alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [tempArray addObject:model];

    }
    return tempArray.copy;

}

/**
 *  @brief 数组(root)[数组1{字典.....},数组2,数组3......]
 *
 *  @param className 模型类名
 *  @param plistName plist文件名
 *
 *  @return 返回模型数组
 */
+ (instancetype)add_arrayWithArrayClassName:(NSString *)className plistName:(NSString *)plistName {

    //获取文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    //读取文件
    NSArray *rootArray = [NSArray arrayWithContentsOfURL:url];
    //字典转模型
    NSMutableArray *tempRootArray = [NSMutableArray array];

    for(NSArray * array in rootArray ) {

        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {

            Class clz  = NSClassFromString(className);
            NSObject * model = [[clz alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [tempArray addObject:model];

        }

        [tempRootArray addObject:tempArray];
    }

    return tempRootArray.copy;

}

/**
 *  @brief 数组(root)[字典1{数组[字典,.....],字符串},字典2,字典3......]
 *
 *  @param className 模型类名
 *  @param plistName plist文件名
 *
 *  @return 返回模型数组
 */
+ (instancetype)add_arrayWithArrayAndDictRootClassName:(NSString *)RootclassName className:(NSString *)className  plistName:(NSString *)plistName {

    //获取文件路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    //读取文件
    NSArray *rootArray = [NSArray arrayWithContentsOfURL:url];
    //字典转模型
    NSMutableArray *tempRootArray = [NSMutableArray array];

    //  外层字典先转模型
    for(NSDictionary *dict in rootArray ) {

        Class clz  = NSClassFromString(RootclassName);
        NSObject * model = [[clz alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [tempRootArray addObject:model];
    }


    //  外层字典模型的数组中,有属性为数组的字典继续进行模型转换,例如:
    /*  为了获取转换后的外层模型的的数组(array1,array2....),必须获取每个数组,通过遍历字典所有keys,将数组名先放到一个数组中
     @property (nonatomic,strong) NSArray *array1;
     @property (nonatomic,strong) NSArray *array2;
     .
     .
     .
     @property (nonatomic,strong) NSArray *arrayN;
     @property (nonatomic,copy)   NSString *name;
     @property (nonatomic,copy)   NSString *icon;
     */

    /**
     *  @brief 遍历字典所有keys,如果字典中有数组,则将这个数组名添加到一个集合数组中.为后面遍历多个数组名转换模型准备.
     */

    NSMutableArray *keyArray = [NSMutableArray array];
    for (NSString *keys in [[rootArray firstObject] allKeys]) {
        if ([[[rootArray firstObject] valueForKey:keys] isKindOfClass:[NSArray class]]) {
            [keyArray addObject:keys];
        }
    }

    /**
     *  @brief 遍历数组(装了keys为数组名),遍历已经转换的外层模型,通过keys获取内层数组[objRoot valueForKey:keys],经典再进行经典模式的字典转模型.
     */

    for (NSString *keys in keyArray) {

        [tempRootArray enumerateObjectsUsingBlock:^(id  _Nonnull objRoot, NSUInteger idx, BOOL * _Nonnull stop) {

            NSMutableArray *tempArray0 = [NSMutableArray array];

            [[objRoot valueForKey:keys] enumerateObjectsUsingBlock:^(id  _Nonnull objTemp, NSUInteger idx, BOOL * _Nonnull stop) {

                Class clz0  = NSClassFromString(className);
                NSObject * model = [[clz0 alloc]init];
                [model setValuesForKeysWithDictionary:objTemp];
                [tempArray0 addObject:model];

            }];
//          重要:将内层已经转换的模型数组重新赋值回去,相当于:self.contents = array;
            [objRoot setValue:tempArray0 forKeyPath:keys];
            
        }];
    }
    return tempRootArray.copy;
}


+ (instancetype)add_arrayWithArrayAndDictRootClassName:(NSString *)RootclassName className:(NSString *)className  jsonName:(NSString *)jsonName {

    // 1. 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:nil];
    // 2. 把文件转为NSData
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 3. 反序列化, 转为字典
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    // 4. 找到需要的数据(数组food_spu_tags)
    NSArray *rootArray = dict[@"data"][@"food_spu_tags"];
    //字典转模型
    NSMutableArray *tempRootArray = [NSMutableArray array];
    //  外层字典先转模型
    for(NSDictionary *dict in rootArray ) {
        Class clz  = NSClassFromString(RootclassName);
        NSObject * model = [[clz alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [tempRootArray addObject:model];
    }
    NSMutableArray *keyArray = [NSMutableArray array];
    for (NSString *keys in [[rootArray firstObject] allKeys]) {
        if ([[[rootArray firstObject] valueForKey:keys] isKindOfClass:[NSArray class]]) {
            [keyArray addObject:keys];
        }
    }
    for (NSString *keys in keyArray) {
        [tempRootArray enumerateObjectsUsingBlock:^(id  _Nonnull objRoot, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *tempArray0 = [NSMutableArray array];
            [[objRoot valueForKey:keys] enumerateObjectsUsingBlock:^(id  _Nonnull objTemp, NSUInteger idx, BOOL * _Nonnull stop) {
                Class clz0  = NSClassFromString(className);
                NSObject * model = [[clz0 alloc]init];
                [model setValuesForKeysWithDictionary:objTemp];
                [tempArray0 addObject:model];
            }];
            [objRoot setValue:tempArray0 forKeyPath:keys];
        }];
    }
    return tempRootArray.copy;
}




@end