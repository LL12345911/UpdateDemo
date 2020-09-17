//
//  ATVersionRequest.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "ATVersionRequest.h"

@implementation ATVersionRequest

+(void)at_versionRequestSuccess:(RequestSucess)success failure:(RequestFailure)failure{
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleId = infoDict[@"CFBundleIdentifier"];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@",bundleId]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(!error){
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    if(success) success(responseDict);
                }else{
                    if(failure) failure(error);
                }
            });
        }];
        [dataTask resume];
    });
}

/**
 *  从AppStore中获取App信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)at_versionRequestWithAppId:(NSString *)appId Success:(RequestSucess)success failure:(RequestFailure)failure{
    NSString *host = @"";
    if (appId.length > 0) {
        host = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appId];
    }else{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *bundleId = infoDict[@"CFBundleIdentifier"];
        host = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@",bundleId];
    }
    NSURL *URL = [NSURL URLWithString:host];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(!error){
                    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    if(success) success(responseDict);
                }else{
                    if(failure) failure(error);
                }
            });
        }];
        [dataTask resume];
    });
}


@end
