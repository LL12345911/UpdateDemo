//
//  ATVersion.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATAppInfo.h"

typedef void(^NewVersionBlock)(ATAppInfo * _Nullable appInfo,BOOL isNewVersion);

//typedef void(^NewVersionBlock)(ATAppInfo * _Nullable appInfo);

NS_ASSUME_NONNULL_BEGIN

@interface ATVersion : NSObject

/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersion;

/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersion1;


/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersionWithAppId:(NSString *)appId;

/**
 *  检测新版本(自定义提示框)
 *
 *  @param newVersion 新版本信息回调
 */
+(void)checkNewVersionAndCustomAlert:(NewVersionBlock)newVersion;

///**
// * 比较版本号
// *
// * @param v1 第一个版本号
// * @param v2 第二个版本号
// *
// * @return 如果版本号相等，返回 0,
// *         如果第一个版本号低于第二个，返回 -1，否则返回 1.
// */
//int compareVersion(const char *v1, const char *v2);

@end

NS_ASSUME_NONNULL_END
