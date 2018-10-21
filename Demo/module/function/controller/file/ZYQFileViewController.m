//
//  ZYQFileViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFileViewController.h"
#import "ZYQFileManager.h"

@interface ZYQFileViewController ()
@property (weak, nonatomic) IBOutlet UITextView *showView;
/**文件路径 */
@property (nonatomic , strong)NSString *filePath;
/**文件夹路径 */
@property (nonatomic , strong)NSString *directoryPath;

@end

@implementation ZYQFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filePath = [[ZYQFileManager ZYQ_getLibraryCaches] stringByAppendingPathComponent:@"my.plist"];
    self.directoryPath = [[ZYQFileManager ZYQ_getLibraryCaches] stringByAppendingPathComponent:@"myfiles"];
}
//获取文件路径
- (IBAction)getPath:(id)sender {
    NSString *docum     = [ZYQFileManager ZYQ_getDocuments];
    NSString *tmp       = [ZYQFileManager ZYQ_getTmp];
    NSString *libCaches = [ZYQFileManager ZYQ_getLibraryCaches];
    self.showView.text = [NSString stringWithFormat:@"文件路径Documents = %@\ntmp = %@\nlibraryCaches = %@" ,docum , tmp , libCaches];
}
//创建文件或者文件夹
- (IBAction)creatFileOrDirectory:(id)sender {
    self.filePath = [[ZYQFileManager ZYQ_getLibraryCaches] stringByAppendingPathComponent:@"my.plist"];
    self.directoryPath = [[ZYQFileManager ZYQ_getLibraryCaches] stringByAppendingPathComponent:@"myfiles"];
    if ( [ZYQFileManager ZYQ_createDirectoryWithPath:self.directoryPath]) {
        self.showView.text = [NSString stringWithFormat:@"成功创建了文件夹,地址是:%@", self.directoryPath];
    }
    if ([ZYQFileManager ZYQ_createFileWithPath:self.filePath data:[[NSData alloc]initWithBase64EncodedString:@"就是一些文件的解释操作等等" options:NSDataBase64DecodingIgnoreUnknownCharacters]]) {
        self.showView.text =  [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\n成功创建了文件,地址是:%@", self.filePath]];
    }
}
//判断文件或者文件夹是否有读写权限
- (IBAction)fileIsReadOrWrite:(id)sender {
    BOOL isRead = [ZYQFileManager ZYQ_isReadAtPath:self.filePath];
    if (isRead) {
        self.showView.text = [NSString stringWithFormat:@"my.plist文件具有读取权限"];
    }else {
       self.showView.text = [NSString stringWithFormat:@"my.plist文件没有读取权限"];
    }
    
    BOOL isWrite = [ZYQFileManager ZYQ_isWriteAtPath:self.filePath];
    
    if (isWrite) {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\nmy.plist文件具有写的权限"]];
    }else {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\nmy.plist文件没有写的权限"]];
    }
}
//判断一个文件是不是文件夹
- (IBAction)isDirectory:(id)sender {
    if ( [ZYQFileManager ZYQ_isDirectoryAtPath:self.filePath]) {
        self.showView.text = [NSString stringWithFormat:@"%@是文件夹" , self.filePath];
    }else {
        self.showView.text = [NSString stringWithFormat:@"%@不是文件夹" , self.filePath];
    }
    if ([ZYQFileManager ZYQ_isDirectoryAtPath:self.directoryPath]) {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\n%@是文件夹",self.directoryPath]];
    }else {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\n%@不是文件夹",self.directoryPath]];
    }
}
//判断文件是否可以删除
- (IBAction)isRemove:(id)sender {
    if ( [ZYQFileManager ZYQ_isDeleteAtPath:self.filePath]) {
        self.showView.text = [NSString stringWithFormat:@"%@可以删除" , self.filePath];
    }else {
        self.showView.text = [NSString stringWithFormat:@"%@不可以删除" , self.filePath];
    }
    if ([ZYQFileManager ZYQ_isDeleteAtPath:self.directoryPath]) {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\n%@可以删除",self.directoryPath]];
    }else {
        self.showView.text = [self.showView.text stringByAppendingString: [NSString stringWithFormat:@"\n%@不可以删除",self.directoryPath]];
    }
    
}
//删除文件或者文件夹
- (IBAction)deleteFile:(id)sender {
    if ( [ZYQFileManager ZYQ_isDeleteAtPath:self.filePath]) {
        [ZYQFileManager ZYQ_removeDirectoryAtPath:self.filePath];
        self.showView.text = [NSString stringWithFormat:@"%@已经删除" , self.filePath];
    }
    if ([ZYQFileManager ZYQ_isDeleteAtPath:self.directoryPath]) {
        [ZYQFileManager ZYQ_removeDirectoryAtPath:self.directoryPath];
        self.showView.text = [NSString stringWithFormat:@"%@已经删除" , self.directoryPath];
    }
}
//拷贝或者移动文件
- (IBAction)copyOrMoveFile:(id)sender {
    NSString *toPath = [[ZYQFileManager ZYQ_getDocuments] stringByAppendingPathComponent:@"my.plist"];
    [ZYQFileManager ZYQ_moveDirectoryfromPath:self.filePath to:toPath];
    self.showView.text = [NSString stringWithFormat:@"已经将%@文件移动到了%@" , self.filePath , toPath];
     toPath = [[ZYQFileManager ZYQ_getDocuments] stringByAppendingPathComponent:@"my"];
    [ZYQFileManager ZYQ_copyDirectoryOrFilefromPath:self.directoryPath to:toPath];
    self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\n已经将%@文件拷贝到了%@" , self.filePath , toPath]];
}
//获得所有的文件或者文件夹
- (IBAction)getAllFiles:(id)sender {
    NSArray * arr = [ZYQFileManager ZYQ_getDirectoryWithFile:[ZYQFileManager ZYQ_getDocuments]];
    for (id str in arr) {
        self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@下的尚文件%@" , [ZYQFileManager ZYQ_getDocuments], str]];
    }
}
//获得文件夹下的文件
- (IBAction)getFiles:(id)sender {
    NSArray * arr = [ZYQFileManager ZYQ_getAllDirectoryWithFile:[ZYQFileManager ZYQ_getDocuments]];
    for (id str in arr) {
        self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\n%@下的尚文件%@" , [ZYQFileManager ZYQ_getDocuments], str]];
    }
}
//获得文件大小和信息
- (IBAction)geZYQileSizeAndInfo:(id)sender {
   NSInteger size = [ZYQFileManager ZYQ_getDirectoryOrFileSizeWithPath:self.filePath];
   NSDate *date  = [ZYQFileManager ZYQ_getDirectoryOrFileCreatDateWithPath:self.filePath];
   NSDate *changeDate = [ZYQFileManager ZYQ_getDirectoryOrFileChangeDateWithPath:self.filePath];
   NSString * str = [ZYQFileManager ZYQ_getDirectoryOrFileOwnerWithPath:self.filePath];
    self.showView.text = [NSString stringWithFormat:@"文件大小:%ld\n 文件创建时间:%@\n 文件修改时间:%@\n 文件所有者:%@\n" ,size, date,changeDate,str];
}

@end
