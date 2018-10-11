//
//  ZYQRuntimeManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQRuntimeManager : NSObject
#pragma mark -- 获得方法、属性
/**
 获取一个类中所有的方法
 @param className 类名
 @return 方法字符串数组
 */
+ (NSArray *)ZYQ_getAllMethodWithClass:(Class)className;
/**
 获取一个类中的所有属性名
 @param className 类名
 @return 属性字符串数组
 */
+ (NSArray *)ZYQ_getAllIvarWithClass:(Class )className;

#pragma mark -- 添加方法
/**
 添加一个方法
 @param className 添加方法的类的名字
 @param methodName 方法名字
 @param impClassName 实现方法的类名
 @param impName 实现方法的方法名
 @param type 添加方法的类型 //可以参考 https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100  举例: v@:@  ,  v-->返回值是void，@-->参数一是id ，：-->参数二是方法，@ --> 参数三是id
 @return 是否添加成功
 */
+ (BOOL)ZYQ_addMethodWithClass:(Class )className
                   methodName:(NSString *)methodName
                     IMPClass:(Class)impClassName
                      impName:(NSString *)impName
                         type:(NSString *)type;


/**
 添加一个方法
 @param className 添加方法的类的名字
 @param methodSel 添加的方法
 @param implementationClass 方法的实现类
 @param implementationSel 实现的方法
 @return 是否添加成功
 */
+ (BOOL)ZYQ_addMethodWithWithClass:(Class )className
                        methodSel:(SEL)methodSel
              implementationClass:(Class)implementationClass
                implementationSel:(SEL)implementationSel;

#pragma mark -- 交换两个方法

/**
 交换两个方法
 @param sourceClass 源方法所在的类名
 @param sourceSel 源方法
 @param targetClass 目标方法所在的类名
 @param targetSel 目标方法
 */
+ (void)ZYQ_exchangeMethodSourceClass:(Class)sourceClass
                           sourceSel:(SEL)sourceSel
                         targetClass:(Class)targetClass
                           targetSel:(SEL)targetSel;

#pragma mark -- 取代方法
/**
 取代某个方法
 @param sourceClass 要取代的方法的类名
 @param sourceSel 要取代的方法名称
 @param targetClass 取代的方法的类名
 @param targetSel 取代的方法的名称
 */
+ (void)ZYQ_replaceMethodSourceClass:(Class)sourceClass
                         sourceSel:(SEL)sourceSel
                       targetClass:(Class)targetClass
                         targetSel:(SEL)targetSel;

#pragma mark -- 字典模型转换
/**
 字典转换为模型对象
 @param dict 字典
 @param model 模型对象
 @return 转换后的模型
 */
+ (id)ZYQ_modelWithDict:(NSDictionary *)dict
                 model:(id)model;

#pragma mark -- 归档解档

/**
 归档
 @param modelClass 要归档的类型
 @param model 要归档的模型
 @param path 文件路径
 @return 是否归档成功
 */
+ (BOOL)ZYQ_archive:(Class)modelClass
             model:(id)model
          filePath:(NSString *)path;

/**
 解档
 @param modelClass 要解档的类型
 @param path 文件路径
 @return 解档后的模型对象
 */
+ (id)ZYQ_unarchive:(Class)modelClass
          filePath:(NSString *)path;




@end
