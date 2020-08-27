//
//  RACSignal+RRScheduler.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "RACSignal+RRScheduler.h"

@implementation RACSignal (RRScheduler)

-(RACSignal*)subscribeOnBackgroundAndDeliverOnMainThread {
    return [[self subscribeOn:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground]]
    deliverOn:[RACScheduler mainThreadScheduler]];
}

@end
