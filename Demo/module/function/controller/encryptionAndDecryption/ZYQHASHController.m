//
//  ZYQHASHController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHASHController.h"
#import "ZYQHash.h"

@interface ZYQHASHController ()
<UITableViewDelegate , UITableViewDataSource>
/** inpuZYQield */
@property (nonatomic , strong)UITextField *inputField;
/** 输出的加密字符串 */
@property (nonatomic , strong)UITextView *outTextView;
/** datasource */
@property (nonatomic , strong)NSArray *dataSource;
@end

@implementation ZYQHASHController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"最基本的MD5加密 -- 点击进行加密" , @"MD5加盐加密 -- 点击进行加密" , @"sha1加密 -- 点击进行加密", @"sha256加密 -- 点击进行加密", @"HMACmd5加密 -- 点击进行加密", @" HMACsha1加密 -- 点击进行加密"];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width, 50)];
    inputField.placeholder = @"请输入要加密的文字";
    [self.view addSubview:inputField];
    self.inputField = inputField;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 , self.view.frame.size.width, 40 * self.dataSource.count)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.outTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40 * self.dataSource.count + 50, self.view.frame.size.width, self.view.frame.size.height - 40 * self.dataSource.count - 50)];
    self.outTextView.backgroundColor = kNavColor;
    self.outTextView.editable = false;
    self.outTextView.textColor = [UIColor whiteColor];
    self.outTextView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.outTextView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self md5Str];
            break;
        case 1:
            [self md5SaltingStr];
            break;
        case 2:
            [self sha1Str];
            break;
        case 3:
            [self sha256Str];
            break;
        case 4:
            [self hmacMD5];
            break;
        case 5:
            [self hmacSHA1];
            break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark - 加密方法
- (void)md5Str{
    self.outTextView.text = [ZYQHash ZYQ_md5WithSttring:self.inputField.text];
}
- (void)md5SaltingStr {
    self.outTextView.text = [ZYQHash ZYQ_md5SaltingWithSttring:self.inputField.text];
}
- (void)sha1Str {
    self.outTextView.text = [ZYQHash ZYQ_sha1WithString:self.inputField.text];
}
- (void)sha256Str {
    self.outTextView.text = [ZYQHash ZYQ_sha256WithString:self.inputField.text];
}
- (void)hmacMD5 {
    self.outTextView.text = [ZYQHash ZYQ_hmacMD5WithString:self.inputField.text Key:@"123"];
}
- (void)hmacSHA1 {
    self.outTextView.text = [ZYQHash ZYQ_hmacSHA1WithString:self.inputField.text key:@"123"];
}



@end
