//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//
//
//  ZYQSphereModel.h
//  SphereTagDemo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYQSphereModel : NSObject
/** 标题 */
@property(nonatomic , strong)NSString *title;
/** 图片 */
@property(nonatomic , strong)NSString *imageStr;

+ (instancetype)createModel:(NSString *)title
                   imageStr:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
