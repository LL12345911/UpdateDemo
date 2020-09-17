//
//  ViewController.m
//  UpdateDemo
//
//  Created by Mars on 2020/9/17.
//  Copyright © 2020 Mars. All rights reserved.
//

#import "ViewController.h"
#import "ATVersion.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [ATVersion checkNewVersion];
    //[ATVersion checkNewVersionWithAppId:@"1237590520"];
    
    
}


@end
