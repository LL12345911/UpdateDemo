//
//  ATAppInfo.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATAppInfo : NSObject

/**
 *  版本号
 */
@property(nonatomic,copy) NSString *version;

/**
 *  更新日志
 */
@property(nonatomic,copy) NSString *releaseNotes;

/**
 *  更新时间
 */
@property(nonatomic,copy) NSString *currentVersionReleaseDate;

/**
 *  APPId
 */
@property(nonatomic,copy) NSString *trackId;

/**
 *  bundleId
 */
@property(nonatomic,copy) NSString *bundleId;

/**
 *  AppStore地址
 */
@property (nonatomic,copy) NSString *trackViewUrl;

- (instancetype)initWithResult:(NSDictionary *)result;

@end

NS_ASSUME_NONNULL_END
