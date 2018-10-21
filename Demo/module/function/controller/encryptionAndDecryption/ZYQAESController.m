//
//  ZYQAESController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAESController.h"
#import "ZYQAES.h"

@interface ZYQAESController ()<UITableViewDelegate , UITableViewDataSource>
/** inputField */
@property (nonatomic , strong)UITextField *inputField;
/** 输出的加密字符串 */
@property (nonatomic , strong)UITextView *outTextView;
/** datasource */
@property (nonatomic , strong)NSArray *dataSource;
/** 要解密的字符串1 */
@property (nonatomic , strong)NSString *encryptStr1;
/** 要解密的数据2 */
@property (nonatomic , strong)NSString *encryptStr2;
/** 要解密的数据3 */
@property (nonatomic , strong)NSString *encryptStr3;
@end

@implementation ZYQAESController

#define kAESIv  @"0000000000000010"
#define keyStr  @"0000000000011110"

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"AES-CBC模式加密 -- 点击进行加密" , @"AES-ECB模式加密 -- 点击进行加密", @"AES256加密 -- 点击进行加密"  , @"AES-CBC模式解密 -- 点击进行解密", @"AES-ECB模式解密 -- 点击进行解密"  , @"AES256解密 -- 点击进行解密"];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 40 * self.dataSource.count)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.outTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40 * self.dataSource.count + 50, self.view.frame.size.width, self.view.frame.size.height - 40 * self.dataSource.count - 50)];
    self.outTextView.backgroundColor = kNavColor;
    self.outTextView.textColor = [UIColor whiteColor];
    self.outTextView.font = [UIFont systemFontOfSize:17];
    self.outTextView.editable = false;
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
            [self encrptyAES_CBC];
            break;
        case 1:
            [self encrptyAES_ECB];
            break;
        case 2:
            [self encryptAES256];
            break;
        case 3:
            [self decrptyAES_CBC];
            break;
        case 4:
            [self decrptyAES_ECB];
            break;
        case 5:
            [self decrptyAES256];
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
- (void)encrptyAES_CBC {
    self.encryptStr1 =  [ZYQAES ZYQ_encrptyWithNSString:self.inputField.text key:keyStr iv:kAESIv];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串是:%@" , self.encryptStr1];
}
- (void)encrptyAES_ECB {
    self.encryptStr2 = [ZYQAES ZYQ_encrptyWithString:self.inputField.text key:keyStr];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串是:%@" , self.encryptStr2];
}
- (void)encryptAES256 {
    self.encryptStr3 = [ZYQAES ZYQ_AES256EncryptWithString:self.inputField.text key:keyStr];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串是:%@" , self.encryptStr3];
}
#pragma mark - 解密方法
- (void)decrptyAES_CBC {
    if ([self.encryptStr1 isEqualToString:@""] || self.encryptStr1 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    NSString *str =  [ZYQAES ZYQ_decrptyWithString:self.encryptStr1  key:keyStr iv:kAESIv];
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串是:%@" , str];
}
- (void)decrptyAES_ECB {
    if ([self.encryptStr2 isEqualToString:@""] || self.encryptStr2 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    NSString *str = [ZYQAES ZYQ_decrptyWithString:self.encryptStr2 key:keyStr];
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串是:%@" , str];
}
- (void)decrptyAES256 {
    if ([self.encryptStr3 isEqualToString:@""] || self.encryptStr3 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    NSString *str =  [ZYQAES ZYQ_AES256DecryptWithString:self.encryptStr3 key:keyStr];
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串是:%@" , str];
}



@end
