//
//  AppDelegate.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIViewController_RRNib.h"
#import "UINavigationController_RRRoot.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [UINavigationController initWithRootVC:[ViewController initWithNib]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
