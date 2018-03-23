//
//  AppDelegate.m
//  HybridDemo
//
//  Created by liweiqiang on 2018/3/19.
//  Copyright © 2018年 TendCloud. All rights reserved.
//

#import "AppDelegate.h"
#import "TalkingData.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TalkingData sessionStarted:@"DE40FB8A722D454B8981E2F842E6AAB6" withChannelId:@"AppStore"];
    return YES;
}

@end
