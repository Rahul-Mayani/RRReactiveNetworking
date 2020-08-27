//
//  RACSignal+RRScheduler.h
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignal (RRScheduler)

-(RACSignal*)subscribeOnBackgroundAndDeliverOnMainThread;

@end
