//
//  UINavigationController_RRRoot.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "UINavigationController_RRRoot.h"

@implementation UINavigationController (UINavigationController_RRRoot)

+(id)initWithRootVC:(UIViewController*)vc
{
    UINavigationController *nav = [[self alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    return nav;
}

@end
