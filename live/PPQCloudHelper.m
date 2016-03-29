//
//  PPQCloudHelper.m
//  live
//
//  Created by chenpeiwei on 3/29/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

#import "PPQCloudHelper.h"

#import <TLSSDK/TLSHelper.h>
#import <QALSDK/QalSDKProxy.h>

@implementation PPQCloudHelper
+(void)setupTLS {
    
    (void)[[QalSDKProxy sharedInstance]initQal:1400007955];
    (void)[[TLSHelper getInstance]init:1400007955 andAppVer: @"1.0"];

}
@end
