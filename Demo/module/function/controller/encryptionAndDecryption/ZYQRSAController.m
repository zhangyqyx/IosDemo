//
//  ZYQRSAController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRSAController.h"
#import "ZYQRSA.h"

#define kPrivateKey  @"-----BEGIN PRIVATE KEY-----\
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANCNEpESh4Lv0Rjg\
5xwa+iSILHf6D4rWPIMwGHF9Fgt/M9CertoxZsIh/uVRu0s/Rn6zc/xZnIV9vooa\
j08enB8CDS8GE0XV5kcM1502p4hmSmRErOhxfbzD9CXMPHQ4UcH5p+Yvd7eRSY0J\
LSi3Ev7EVjLwc8XGnb+ozbHRgWKLAgMBAAECgYBB6NO9VYXOM8x5eFqR31S+xuqG\
4FiZICvvqfuPomCdMY5GmF/aRVKcd/H+t13h4hV9ZWl6jzeQWLUnIE26S4o7EEQU\
nuyAWfoGTCCPIwHnlxVzHTevdvPPstGp9+QpbDJPsLSgsfmNKIVdE/o+FaJ8N+5R\
VyWLsXP64Qus5spagQJBAPNc+4WXPPHEAwQ5e6yCTOMrbLDWkIgbP+vObIGSG41E\
RxDxfvgDKn682CB3ID1CzX5ujkoP4kwF+VA7PS5qOvMCQQDbYVVhbB/AT1oCAcL3\
ZROmwRpZqUuRifUZZCgd5VyFIrD1g3Z2Hgq5IYzx6lCo3372eRRqYkV7MLA70N/K\
2XAJAkBq4ch5uJ2ElRC6F0Dw191K3DSFSgb6L/WX6/YNxgyhs33+vAGGjWVpeij1\
wTwAi8lSoN2PO4Co4OrJSOsq6m7vAkEArzltMuVj7vzyjYvOqD/JlHXEkD0SqOqi\
JGfFSyu53HU7Fr6sTefs9LYBl/BqAJiTFlbboaVgjebzvLM3LRTD0QJBALbXFEw4\
zm6FjJidP48wVpr93OiriYbmlknrVB4M9Hu2vyOO9hmuhngsuzTOHBG9iOl+mIM4\
VLntuNqwgdqrRm8=\
-----END PRIVATE KEY-----"
#define kPublicKey @"-----BEGIN PUBLIC KEY-----\
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQjRKREoeC79EY4OccGvokiCx3\
+g+K1jyDMBhxfRYLfzPQnq7aMWbCIf7lUbtLP0Z+s3P8WZyFfb6KGo9PHpwfAg0v\
BhNF1eZHDNedNqeIZkpkRKzocX28w/QlzDx0OFHB+afmL3e3kUmNCS0otxL+xFYy\
8HPFxp2/qM2x0YFiiwIDAQAB\
-----END PUBLIC KEY-----"

@interface ZYQRSAController ()<UITableViewDelegate , UITableViewDataSource>
/** inputField */
@property (nonatomic , strong)UITextField *inputField;
/** 输出的加密字符串 */
@property (nonatomic , strong)UITextView *outTextView;
/** datasource */
@property (nonatomic , strong)NSArray *dataSource;
/** 要解密的字符串1 */
@property (nonatomic , strong)NSString *encryptStr1;
/** 要解密的字符串2 */
@property (nonatomic , strong)NSString *encryptStr2;

@end

@implementation ZYQRSAController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"RSA加密 -- 点击进行加密" , @"RSA文件路径加密 -- 点击进行加密" , @"RSA解密 -- 点击进行解密", @"RSA文件路径解密 -- 点击进行解密"];
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
    self.outTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 40 * self.dataSource.count + 50, self.view.frame.size.width, self.view.frame.size.height - 40 * self.dataSource.count - 50 )];
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
            [self encryptRSAStr];
            break;
        case 1:
            [self encryptRSAFileStr];
            break;
        case 2:
            [self decryptRSAStr];
            break;
        case 3:
            [self decryptRSAFileStr];
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
- (void)encryptRSAStr{
    self.encryptStr1 = [ZYQRSA ZYQ_encryptString:self.inputField.text publicKey:kPublicKey];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串:%@" ,self.encryptStr1];
}
- (void)encryptRSAFileStr {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"rsacert" ofType:@"der"];
    self.encryptStr2 = [ZYQRSA ZYQ_encryptNSString:self.inputField.text publicKeyWithPath:filepath];
    self.outTextView.text = [NSString stringWithFormat:@"加密后的字符串:%@" ,self.encryptStr2];
}
#pragma mark - 解密方法
- (void)decryptRSAStr {
    if ([self.encryptStr1 isEqualToString:@""] || self.encryptStr1 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串:%@" ,[ZYQRSA ZYQ_decryptString:self.encryptStr1 privateKey:kPrivateKey]];
}
- (void)decryptRSAFileStr {
    if ( self.encryptStr2 == nil) {
        self.outTextView.text = @"没有要解密的数据";
        return;
    }
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"p" ofType:@"p12"];
    self.encryptStr2 = [ZYQRSA ZYQ_decryptNSString:self.encryptStr2 privateKeyWithPath:filepath password:@"zhangyq"];
    self.outTextView.text = [NSString stringWithFormat:@"解密后的字符串:%@" ,self.encryptStr2];
    
}

@end
