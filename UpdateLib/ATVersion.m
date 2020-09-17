//
//  ATVersion.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "ATVersion.h"
#import "ATVersionRequest.h"
#import <StoreKit/StoreKit.h>
#import "ATUpdateAlert.h"

@interface ATVersion()<UIAlertViewDelegate>

@property(nonatomic,strong) ATAppInfo *appInfo;
@property(nonatomic,copy) NSString *appId;

@end


@implementation ATVersion

+(void)checkNewVersion{
    [[ATVersion shardManger] checkNewVersion:1];
}

/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersion1{
     [[ATVersion shardManger] checkNewVersion:0];
}

/**
 *  检测新版本(使用默认提示框)
 */
+(void)checkNewVersionWithAppId:(NSString *)appId{
    [ATVersion shardManger].appId = appId;
    [[ATVersion shardManger] checkNewVersion:0];
}

+(void)checkNewVersionAndCustomAlert:(NewVersionBlock)newVersion{
    [[ATVersion shardManger] checkNewVersionAndCustomAlert:newVersion];
}

#pragma mark - private

+(ATVersion *)shardManger{
    static ATVersion *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[ATVersion alloc] init];
    });
    return instance;
}


-(void)checkNewVersion:(NSInteger)flag{
    __weak typeof(self) weakSelf = self;
    [self versionRequest:^(ATAppInfo * _Nullable appInfo, BOOL isNewVersion) {
        if (isNewVersion) {
            for (UIView *subView in [weakSelf window].window.subviews) {
                if ([subView isKindOfClass:[ATUpdateAlert class]]) {
                    [subView removeFromSuperview];
                }
            }
            [ATUpdateAlert showUpdateAlert:appInfo];
        }else{
            if (flag == 1) {
                [HUDTools showText:@"已是最新版本!"];
            }
        }
        DebugLog(@"🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔 version = %@", appInfo.version);
        DebugLog(@"🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔 检测更新----有没有新版本 %@", isNewVersion ? @"YES":@"NO");
    }];
//
//    [self versionRequest:^(ATAppInfo *appInfo) {
//        for (UIView *subView in [self window].window.subviews) {
//            if ([subView isKindOfClass:[ATUpdateAlert class]]) {
//                [subView removeFromSuperview];
//            }
//        }
//         [ATUpdateAlert showUpdateAlert:appInfo];
//    }];
}
//获取当前控制器
- (UIViewController *)currentViewController {
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}


-(UIWindow *)window{
//    [[self window].rootViewController presentViewController:alert animated:YES completion:nil];
    UIWindow *window = nil;
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(window)]) {
        window = [delegate performSelector:@selector(window)];
    } else {
        window = [[UIApplication sharedApplication] keyWindow];
    }
    return window;
}


-(void)checkNewVersionAndCustomAlert:(NewVersionBlock)newVersion{
    [self versionRequest:^(ATAppInfo * _Nullable appInfo, BOOL isNewVersion) {
         if(newVersion) newVersion(appInfo,isNewVersion);
    }];
    
//    [self versionRequest:^(ATAppInfo *appInfo) {
//        if(newVersion) newVersion(appInfo);
//    }];
}


-(void)versionRequest:(NewVersionBlock)newVersion{
    [ATVersionRequest at_versionRequestWithAppId:_appId Success:^(NSDictionary * _Nullable responseDict) {
        NSInteger resultCount = [responseDict[@"resultCount"] integerValue];
        if(resultCount==1){
            NSArray *resultArray = responseDict[@"results"];
            DebugLog(@"🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔🔔 \n%@",resultArray);
            NSDictionary *result = resultArray.firstObject;
            ATAppInfo *appInfo = [[ATAppInfo alloc] initWithResult:result];
            NSString *version = appInfo.version;
            self.appInfo = appInfo;
            //新版本
            if([self isNewVersion:version]){
                if(newVersion) newVersion(self.appInfo,YES);
            }else{
                if(newVersion) newVersion(self.appInfo,NO);
            }
        }else{
            if(newVersion) newVersion(nil,NO);
        }
        
    } failure:^(NSError * _Nullable error) {
        if(newVersion) newVersion(nil,NO);
    }];
}


-(void)openInAppStoreForAppURL:(NSString *)appURL{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
#pragma clang diagnostic pop
}


- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}


//是否是新版本
-(BOOL)isNewVersion:(NSString *)newVersion{
    return [self newVersion:newVersion moreThanCurrentVersion:[self currentVersion]];
}


-(NSString * )currentVersion{
    NSString *key = @"CFBundleShortVersionString";
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    return currentVersion;
}
-(BOOL)newVersion:(NSString *)newVersion moreThanCurrentVersion:(NSString *)currentVersion{
    if ([self compareVersion2:newVersion to:currentVersion] == 1) {
        return YES;
    }
    return NO;
    
}

/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
- (NSInteger)compareVersion2:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }
    
    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }
    
    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最大的，进行循环比较
    NSInteger bigCount = (v1Array.count > v2Array.count) ? v1Array.count : v2Array.count;
    
    for (int i = 0; i < bigCount; i++) {
        // 字段有值，取值；字段无值，置0。
        NSInteger value1 = (v1Array.count > i) ? [[v1Array objectAtIndex:i] integerValue] : 0;
        NSInteger value2 = (v2Array.count > i) ? [[v2Array objectAtIndex:i] integerValue] : 0;
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }
        // 版本相等，继续循环。
    }
    
    // 版本号相等
    return 0;
    
}
///**
// * 比较版本号
// *
// * @param v1 第一个版本号 新版本号
// * @param v2 第二个版本号 当前版本号
// *
// * @return 如果版本号相等，返回 0,
// *         如果第一个版本号低于第二个，返回 -1，否则返回 1.
// */
//int compareVersion(const char *v1, const char *v2){
//    assert(v1);
//    assert(v2);
//    
//    const char *p_v1 = v1;
//    const char *p_v2 = v2;
//    
//    while (*p_v1 && *p_v2) {
//        char buf_v1[32] = {0};
//        char buf_v2[32] = {0};
//        
//        char *i_v1 = strchr(p_v1, '.');
//        char *i_v2 = strchr(p_v2, '.');
//        
//        if (!i_v1 || !i_v2) break;
//        
//        if (i_v1 != p_v1) {
//            strncpy(buf_v1, p_v1, i_v1 - p_v1);
//            p_v1 = i_v1;
//        }else{
//            p_v1++;
//        }
//        
//        if (i_v2 != p_v2) {
//            strncpy(buf_v2, p_v2, i_v2 - p_v2);
//            p_v2 = i_v2;
//        }else{
//            p_v2++;
//        }
//        
//        int order = atoi(buf_v1) - atoi(buf_v2);
//        if (order != 0){
//            return order < 0 ? -1 : 1;
//        }
//    }
//    
//    double res = atof(p_v1) - atof(p_v2);
//    
//    if (res < 0) return -1;
//    if (res > 0) return 1;
//    return 0;
//}


//
//int main(int argc, char *argv[])
//{
//    assert(compare_version("2.2.1", "2.2.0") > 0);
//    assert(compare_version("2.2.1", "2.1.9") > 0);
//    assert(compare_version("2.2.1", "2.2.01") == 0);
//    assert(compare_version("2.2.1", "2.2.1") == 0);
//    assert(compare_version("2.2", "2.1.1") > 0);
//    assert(compare_version("2.2", "2.2.1") < 0);
//    assert(compare_version("2.2.3.1", "2.2.3.5") < 0);
//    assert(compare_version("2.2.3.1", "2.2.3.0") > 0);
//    assert(compare_version("2.2", "2.2.1.4.5") < 0);
//    assert(compare_version("2.2.3.4", "2.2.4.4.5") < 0);
//    assert(compare_version("2.2.3.4.5.6", "2.2.3.4.5.12") < 0);
//    assert(compare_version("2.2.3.4.5.6", "2.2.2.4.5.12") > 0);
//    assert(compare_version("3.0.0.1", "3.0.0.0.1") > 0);
//    assert(compare_version("3.1", "3.1.") == 0);
//
//    puts("test pass.");
//}



@end
