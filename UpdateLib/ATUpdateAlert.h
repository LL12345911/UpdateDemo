//
//  ATUpdateAlert.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ATAppInfo;

NS_ASSUME_NONNULL_BEGIN

@interface ATUpdateAlert : UIView

/**
 添加版本更新提示
 
 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions;

/**
 添加版本更新提示
 
 @param version 版本号
 @param description 版本更新内容（字符串）
 
 description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description;


/**
 添加版本更新提示

 @param appInfo app信息
 */
+ (void)showUpdateAlert:(ATAppInfo *)appInfo;

@end

NS_ASSUME_NONNULL_END
