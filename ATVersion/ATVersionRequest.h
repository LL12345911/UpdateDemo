//
//  ATVersionRequest.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSucess) (NSDictionary * _Nullable responseDict);
typedef void(^RequestFailure) (NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ATVersionRequest : NSObject

/**
 *  从AppStore中获取App信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)at_versionRequestSuccess:(RequestSucess)success failure:(RequestFailure)failure;


/**
 *  从AppStore中获取App信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)at_versionRequestWithAppId:(NSString * __nullable)appId Success:(RequestSucess)success failure:(RequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
