//
//  ZYQFileManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQFileManager : NSObject

#pragma mark -- 文件相关操作

/**
 判断当前目录下文件是否存在
 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)ZYQ_isExistAtPath:(NSString *)path;

/**
  判断是否是文件夹
 @param path 文件夹路径
 @return 是否是文件夹
 */
+ (BOOL)ZYQ_isDirectoryAtPath:(NSString *)path;
/**
 判断文件是否可读
 @param path 文件路径
 @return 是否可读
 */
+ (BOOL)ZYQ_isReadAtPath:(NSString *)path;
/**
 判断文件是否可写
 @param path 文件路径
 @return 是否可写
 */
+ (BOOL)ZYQ_isWriteAtPath:(NSString *)path;
/**
 判断文件是否可删除
 @param path 文件路径
 @return 是否可删除
 */
+ (BOOL)ZYQ_isDeleteAtPath:(NSString *)path;

#pragma mark -- 获取文件路径
//app路径
+ (NSString *)ZYQ_getAppPath;
//Documents
+ (NSString *)ZYQ_getDocuments;
//Tmp
+ (NSString *)ZYQ_getTmp;
//LibraryCaches
+ (NSString *)ZYQ_getLibraryCaches;

#pragma mark -- 获取文件目录

/**
 获取文件下所有的文件及文件夹下的子文件

 @param path 文件路径
 @return 所有文件
 */
+ (NSArray *)ZYQ_getAllDirectoryWithFile:(NSString *)path;

/**
 获取文件夹下的文件以及文件夹（不包括子文件）

 @param path 文件路径
 @return 所有文件
 */
+ (NSArray *)ZYQ_getDirectoryWithFile:(NSString *)path;

#pragma mark -- 文件管理

/**
 创建一个文件夹

 @param path 文件夹路径
 @return 是否成功
 */
+ (BOOL)ZYQ_createDirectoryWithPath:(NSString *)path;
/**
 创建一个文件
 @param path 文件路径
 @param fileData 写入文件的内容
 @return 是否成功
 */
+ (BOOL)ZYQ_createFileWithPath:(NSString *)path data:(NSData *)fileData;

/**
 删除一个文件以及文件夹

 @param path 文件路径
 @return 是否成功
 */
+ (BOOL)ZYQ_removeDirectoryAtPath:(NSString *)path;
/**
 移动一个文件或者重命名文件
 @param from 要移动的文件路径
 @param to 移动到的文件路径（不能是已经存在的）
 @return 是否成功
 */
+ (BOOL)ZYQ_moveDirectoryfromPath:(NSString *)from to:(NSString *)to;

/**
 拷贝一个文件或文件
 @param from 要拷贝的文件路径
 @param to 拷贝到哪里的文件路径
 @return 是否成功
 */
+ (BOOL)ZYQ_copyDirectoryOrFilefromPath:(NSString *)from to:(NSString *)to;

/**
 获取创建文件时间
 @param path 文件路径
 @return 时间字符串
 */
+ (NSDate *)ZYQ_getDirectoryOrFileCreatDateWithPath:(NSString *)path;

/**
 获取文件修改日期
 @param path 文件路径
 @return 修改时间
 */
+ (NSDate *)ZYQ_getDirectoryOrFileChangeDateWithPath:(NSString *)path;
/**
 获取文件大小
 @param path 文件路径
 @return 大小
 */
+ (unsigned long long )ZYQ_getDirectoryOrFileSizeWithPath:(NSString *)path;

/**
 获取文件所有者
 @param path 文件路径
 @return 文件所有者
 */
+ (NSString *)ZYQ_getDirectoryOrFileOwnerWithPath:(NSString *)path;

/**
 传入文件大小转换为不同类型的文件的大小
 @param size 文件的大小
 @return 文件大小字符串
 */
+ (NSString *)ZYQ_geZYQileSize:(unsigned long long)size;



@end
