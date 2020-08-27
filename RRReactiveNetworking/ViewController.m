//
//  ViewController.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "ViewController.h"
#import "RRApiManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIViewController_RRAlertController.h"
#import "RACSignal+RRScheduler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    
    [RRApiManagerShared showProgressWithStatus:@"" isMask:YES];
    
    NSDictionary *param = @{@"title": @"test", @"body":@"bar", @"userId":@"51"};
    [[[[[RRApiManagerShared postAPICallURL:@"https://jsonplaceholder.typicode.com/posts" header:nil param:param]
    flattenMap:^(id responseOfPostAPI) {
        NSLog(@"%@",responseOfPostAPI);
        return [RRApiManagerShared getAPICallURL:@"https://jsonplaceholder.typicode.com/posts" header:nil];
    }]
    subscribeOnBackgroundAndDeliverOnMainThread]
    subscribeNext:^(id responseGetAPI) {
        NSLog(@"%@",responseGetAPI);
        [self_weak_ showAlertWithTitle:@"Success!" message:@"Both API call successfully.."];
    } error:^(NSError * error) {
        [self_weak_ showAlertWithTitle:@"" message:error.localizedDescription];
    }] rac_deallocDisposable];
}

@end
