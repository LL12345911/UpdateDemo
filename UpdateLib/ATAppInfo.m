//
//  ATAppInfo.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "ATAppInfo.h"

@implementation ATAppInfo

- (instancetype)initWithResult:(NSDictionary *)result{
    self = [super init];
    if (self) {
        self.version = result[@"version"];
        self.releaseNotes = result[@"releaseNotes"];
        self.currentVersionReleaseDate = result[@"currentVersionReleaseDate"];
        self.trackId = result[@"trackId"];
        self.bundleId = result[@"bundleId"];
        self.trackViewUrl = result[@"trackViewUrl"];
    }
    return self;
}

@end
