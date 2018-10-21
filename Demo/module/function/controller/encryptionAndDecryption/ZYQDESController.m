//
//  ZYQDESController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQDESController.h"
#import "ZYQDES.h"

@interface ZYQDESController ()
<UITableViewDelegate , UITableViewDataSource>
/** inputField */
@property (nonatomic , strong)UITextField *inputField;
/** 输出的加密字符串 */
@property (nonatomic , strong)UITextView *outTextView;
/** datasource */
@property (nonatomic , strong)NSArray *dataSource;
/** 要解密的字符串1 */
@property (nonatomic , strong)NSString *encryptStr1;
/** 要解密的数据2 */
@property (nonatomic , strong)NSData *encryptData2;
@end

@implementation ZYQDESController
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"DES字符串加密 -- 点击进行加密" , @"DESData加密 -- 点击进行加密" , @"DES字符串解密 -- 点击进行解密", @"DESData解密 -- 点击进行解密"];
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
    inputField.placeholder = @"请输入要加密的字符串";
    [self.view addSubview:inputField];
    self.inputField = inputField;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 , self.view.frame.size.width, 40 * self.dataSource.count)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.outTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40 * self.dataSource.count + 50, self.view.frame.size.width, self.view.frame.size.height - 40 * self.dataSource.count - 50 )];
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
            [self encryptStr];
            break;
        case 1:
            [self encryptData];
            break;
        case 2:
            [self decryptStr];
            break;
        case 3:
            [self decryptData];
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
- (void)encryptStr{
    self.encryptStr1 = [ZYQDES ZYQ_encryptWithString:self.inputField.text key:@"123"];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串:%@" ,[ZYQDES ZYQ_encryptWithString:self.inputField.text key:@"123"]];
}
- (void)encryptData {
    self.encryptData2 = [ZYQDES ZYQ_encryptWithData:[self.inputField.text dataUsingEncoding:NSUTF8StringEncoding] dataKey:[@"123" dataUsingEncoding:NSUTF8StringEncoding]];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的data数据:%@" , self.encryptData2];
}
#pragma mark - 解密方法
- (void)decryptStr {
    if ([self.encryptStr1 isEqualToString:@""] || self.encryptStr1 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串:%@" ,[ZYQDES ZYQ_decryptWithString: self.encryptStr1 key:@"123"]];
}
- (void)decryptData {
    if ( self.encryptData2 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    self.outTextView.text = [NSString stringWithFormat:@"解密后的data数据:%@" , [ZYQDES ZYQ_decryptWithData:self.encryptData2 dataKey:[@"123" dataUsingEncoding:NSUTF8StringEncoding]]];
    self.outTextView.text = [NSString stringWithFormat:@"%@   解密后的字符串是:%@" , self.outTextView.text , [[NSString alloc] initWithData:[ZYQDES ZYQ_decryptWithData:self.encryptData2 dataKey:[@"123" dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding]];
}



@end
