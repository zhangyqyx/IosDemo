//
//  ZYQFileManager.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFileManager.h"

@implementation ZYQFileManager
#pragma mark -- 文件操作
+ (BOOL)ZYQ_isExistAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
+ (BOOL)ZYQ_isDirectoryAtPath:(NSString *)path {
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    return isDir;
}
+ (BOOL)ZYQ_isReadAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}
+ (BOOL)ZYQ_isWriteAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}
+ (BOOL)ZYQ_isDeleteAtPath:(NSString *)path{
    return [[NSFileManager defaultManager] isDeletableFileAtPath:path];
}
#pragma mark -- 获取文件路径
//app
+ (NSString *)ZYQ_getAppPath {
    return NSHomeDirectory();
}
//Documents
+ (NSString *)ZYQ_getDocuments {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
//Tmp
+ (NSString *)ZYQ_getTmp {
    return NSTemporaryDirectory();
}
//LibraryCaches
+ (NSString *)ZYQ_getLibraryCaches {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

#pragma mark -- 获取文件目录
+ (NSArray *)ZYQ_getAllDirectoryWithFile:(NSString *)path {
    
    return [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil]];
//    return  [[NSFileManager defaultManager] subpathsAtPath:path];//或者使用这种方法
}
+ (NSArray *)ZYQ_getDirectoryWithFile:(NSString *)path {
    return [[NSArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
}
#pragma mark -- 文件管理
+ (BOOL)ZYQ_createDirectoryWithPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}
+ (BOOL)ZYQ_createFileWithPath:(NSString *)path data:(NSData *)fileData {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createFileAtPath:path contents:fileData attributes:nil];
    }
    return NO;
}
+ (BOOL)ZYQ_removeDirectoryAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    return NO;
}
+ (BOOL)ZYQ_moveDirectoryfromPath:(NSString *)from to:(NSString *)to {
    if (![[NSFileManager defaultManager] fileExistsAtPath:to]) {
        return [[NSFileManager defaultManager] moveItemAtPath:from toPath:to error:nil];
    }
    return NO;
}
+ (BOOL)ZYQ_copyDirectoryOrFilefromPath:(NSString *)from to:(NSString *)to {
    return [[NSFileManager defaultManager] copyItemAtPath:from toPath:to error:nil];
}
+ (NSDate *)ZYQ_getDirectoryOrFileCreatDateWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileCreationDate];
}
+ (NSDate *)ZYQ_getDirectoryOrFileChangeDateWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileModificationDate];
}
+ (unsigned long long)ZYQ_getDirectoryOrFileSizeWithPath:(NSString *)path {
    BOOL isDirectory = [self ZYQ_isDirectoryAtPath:path];
    long fileSize = 0;
    if (isDirectory) {
        NSArray *files = [self ZYQ_getAllDirectoryWithFile:path];
        for (NSString *name in files) {
            fileSize += [self ZYQ_geZYQileSizeWithPath:[NSString stringWithFormat:@"%@/%@" , path , name]];
        }
        return fileSize;
    }else {
        return [self ZYQ_geZYQileSizeWithPath:path];
    }
}
+ (unsigned long long)ZYQ_geZYQileSizeWithPath:(NSString *)path {
    //    unsigned long fileLength = 0;
    //    NSNumber *fileSize;
    //    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //    if ((fileSize = [fileAttributes objecZYQorKey:NSFileSize])) {
    //        fileLength = [fileSize unsignedLongLongValue];
    //    }
    //    return fileLength;
    NSFileManager* manager =[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]){
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}
+ (NSString *)ZYQ_getDirectoryOrFileOwnerWithPath:(NSString *)path {
    NSDictionary *fileAttribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return [fileAttribute objectForKey:NSFileOwnerAccountName];
}
+ (NSString *)ZYQ_geZYQileSize:(unsigned long long)size {
    NSString *sizeText = nil;
    if (size >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%lluB", size];
    }
    return sizeText;
}

@end
