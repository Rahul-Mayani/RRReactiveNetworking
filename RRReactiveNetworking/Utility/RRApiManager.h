//
//  RRApiManager.h
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "SVProgressHUD.h"

// access RRApiManager shared instance object
#define RRApiManagerShared  [RRApiManager shared]

@interface RRApiManager : NSObject

/**
 *  Class Method (+)
 */

+ (RRApiManager *) shared;

/**
*  Instance Method (-)
*/

-(RACSignal*)getAPICallURL:(NSString*)url header:(NSDictionary*)header;
-(RACSignal*)getAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param;

-(RACSignal*)postAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param;
-(RACSignal*)putAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param;
-(RACSignal*)patchAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param;
-(RACSignal*)deleteAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param;

//MARK: Progress

-(void)showProgressWithStatus:(NSString*)status isMask:(BOOL)isMask;
-(void)showProgressWithStatus:(NSString*)status isMask:(BOOL)isMask fontColor:(UIColor*)fontColor;
-(void)hideProgressView;

@end

