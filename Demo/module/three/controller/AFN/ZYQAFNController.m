//
//  ZYQAFNController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAFNController.h"
#import "ZYQAFNModel.h"
#import "ZYQNetworkManager.h"
#import "ZYQProgressHUD.h"


@interface ZYQAFNController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** 底部视图 */
@property(nonatomic , strong)UILabel *bottomLabel;
/** 数据源 */
@property(nonatomic , strong)NSArray *dataSource;



@end

@implementation ZYQAFNController

#define kCell @"kcell"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"AFNetworking";
    [self createUI];
    [self loadData];
}

#pragma mark - 设置UI
- (void)createUI {
    [self setupTableView];
    [self stupBottomView];
}
- (void)setupTableView {
    UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZYQ_ScreenWidth, 300) style:UITableViewStylePlain];
    tableView.dataSource    = self;
    tableView.delegate      = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    [self.view addSubview:tableView];
    self.tableView          = tableView;
}
- (void)stupBottomView {
    UILabel *label          = [[UILabel alloc] init];
    label.frame             = CGRectMake(0, self.tableView.ZYQ_viewBottom ,ZYQ_ScreenWidth, ZYQ_ScreenHeight - ZYQ_TopH - self.tableView.ZYQ_viewBottom );
    label.numberOfLines     = 0;
    label.textColor         = [UIColor whiteColor];
    label.backgroundColor   = kNavColor;
    [self.view addSubview:label];
    self.bottomLabel = label;
}

#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQAFNModel loadData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    ZYQAFNModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self getRequest];
            break;
        case 1:
            [self postRequest];
            break;
        case 2:
            [self deleteRequest];
            break;
        case 3:
            [self patchRequest];
            break;
        case 4:
            [self putRequest];
            break;
            
        default:
            break;
    }
}

#pragma mark - 请求
- (void)getRequest {
    [ZYQProgressHUD ZYQloadingAlertWithText:@"正在请求get数据"];
    [ZYQNetworkManager ZYQ_httpForGETWithParam:nil urlStr:@"https://www.baidu.com" outTime:20 progress:^(NSProgress *uploadProgress) {
        ZYQLog(@"uploadProgress=%lld",uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadGetRequestData];
            [ZYQProgressHUD ZYQhide];
        });
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [ZYQProgressHUD ZYQhide];
    }];
}

- (void)postRequest {
    [ZYQProgressHUD ZYQloadingGIFAlertIsCourseSave:NO];
    NSDictionary *dic = @{@"name":@"123",
                          @"id":@"456"
                          };
    [ZYQNetworkManager ZYQ_httpForPOSTWithParam:dic urlStr:@"https://www.baidu.com" outTime:20 progress:^(NSProgress *uploadProgress) {
        ZYQLog(@"uploadProgress=%.2lf",uploadProgress.totalUnitCount/uploadProgress.completedUnitCount * 1.0);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadPostRequestData];
            [ZYQProgressHUD ZYQremoveView];
        });
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
       [ZYQProgressHUD ZYQremoveView];
    }];
    
}

- (void)deleteRequest {
    [ZYQProgressHUD ZYQloadingShowBg];
    [ZYQNetworkManager ZYQ_httpForDELETEWithParam:nil urlStr:@"https://www.baidu.com" outTime:5 success:^(NSURLSessionDataTask *task, id responseObject) {
       [ZYQProgressHUD ZYQhide];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadDeleteRequestData];
            [ZYQProgressHUD ZYQhide];
        });
    }];
}

- (void)patchRequest {
    [ZYQProgressHUD ZYQloadingGIFAlertIsCourseSave:false];
    NSDictionary *dic = @{@"name":@"123",
                          @"id":@"456"
                          };
    [ZYQNetworkManager ZYQ_httpForPATCHWithParam:dic urlStr:@"https://www.baidu.com" outTime:5 success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadPatchRequestData];
            [ZYQProgressHUD ZYQremoveView];
        });
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [ZYQProgressHUD ZYQremoveView];
    }];
    
    
}

- (void)putRequest {
    [ZYQProgressHUD ZYQloadingGIFAlertIsCourseSave:false];
    NSDictionary *dic = @{@"name":@"123",
                          @"id":@"456"
                          };
    [ZYQNetworkManager ZYQ_httpForPUTWithParam:dic urlStr:@"https://www.baidu.com" outTime:5 success:^(NSURLSessionDataTask *task, id responseObject) {
             [ZYQProgressHUD ZYQremoveView];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadPutRequestData];
            [ZYQProgressHUD ZYQremoveView];
        });
    }];
    
}
#pragma mark - 数据
- (void)loadGetRequestData {
    self.bottomLabel.text = @"GET请求指定的页面信息，并返回实体主体。get会将数据缓存起来.http协议并未规定get和post的长度限制,get的最大长度限制是因为浏览器和web服务器限制了URL的长度,要支持IE，则最大长度为2083byte，若支持Chrome，则最大长度8182byte\n\
    get请求的过程：\n\
    （1）浏览器请求tcp连接（第一次握手）\n\
    （2）服务器答应进行tcp连接（第二次握手）\n\
    （3）浏览器确认，并发送get请求头和数据（第三次握手，这个报文比较小，所以http会在此时进行第一次数据发送）\n\
    （4）服务器返回200 OK响应";
}
- (void)loadPostRequestData {
    self.bottomLabel.text = @"POST向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的建立和/或已有资源的修改。get的总耗是post的2/3左右\n\
    post请求的过程：\n\
    （1）浏览器请求tcp连接（第一次握手）\n\
    （2）服务器答应进行tcp连接（第二次握手）\n\
    （3）浏览器确认，并发送post请求头（第三次握手，这个报文比较小，所以http会在此时进行第一次数据发送）\n\
    （4）服务器返回100 Continue响应\n\
    （5）浏览器发送数据\n\
    （6）服务器返回200 OK响应";
}
- (void)loadDeleteRequestData {
    self.bottomLabel.text = @"DELETE请求服务器删除指定的页面。\n\
    DELETE请求一般返回3种码\n\
    200（OK）——删除成功，同时返回已经删除的资源。\n\
    202（Accepted）——删除请求已经接受，但没有被立即执行（资源也许已经被转移到了待删除区域）。\n\
    204（No Content）——删除请求已经被执行，但是没有返回资源（也许是请求删除不存在的资源造成的）。";
}
- (void)loadPatchRequestData {
    self.bottomLabel.text = @"PATCH方法是新引入的，是对PUT方法的补充，用来对已知资源进行局部更新\n\
    PUT 是幂等的，而 PATCH 不是幂等的。幂等是一个数学和计算机学概念，在计算机范畴内表示一个操作执行任意次对系统的影响跟一次是相同。";
}
- (void)loadPutRequestData {
    self.bottomLabel.text = @"PUT请求是向服务器端发送数据的，从而改变信息，该请求就像数据库的update操作一样，用来修改数据的内容，但是不会增加数据的种类等，也就是说无论进行多少次PUT操作，其结果并没有不同。";
}



@end
