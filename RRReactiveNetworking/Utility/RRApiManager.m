//
//  RRApiManager.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "RRApiManager.h"
#import "CURLLog.h"
#import "Constants.h"

@interface RRApiManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation RRApiManager

#pragma mark - Init -

-(id)init
{
    if (self = [super init])
    {
    }
    return self;
}

#pragma mark - Shared Instance -

+ (RRApiManager *) shared {
    
    static dispatch_once_t pred = 0;
    
    __strong static RRApiManager * _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

#pragma mark - AFHTTPSessionManager -

-(AFHTTPSessionManager*)setSessionManagerWithBaseURL:(NSString*)baseURL header:(NSDictionary*)header {
    
    AFHTTPSessionManager *manager;
    
    if (isEmpty(baseURL))
    {
        manager = [[AFHTTPSessionManager manager] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    else
    {
        manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:baseURL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/x-www-form-urlencoded", nil];
    
    if (!isEmpty(header))
    {
        NSArray *aryAllKeyHeader = [header allKeys];
        
        for (NSString *key in aryAllKeyHeader) {
            [manager.requestSerializer setValue:[header valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    return manager;
}

#pragma mark - Custom API -

-(RACSignal*)getAPICallURL:(NSString*)url header:(NSDictionary*)header {
    
    return [self getAPICallURL:url header:header param:nil];
}

-(RACSignal*)getAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.manager = [self setSessionManagerWithBaseURL:nil header:header];
        NSURLSessionDataTask *dataTask = [self getAPIDataTaskWithSubscriber:subscriber url:url header:header param:param];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

-(RACSignal*)postAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.manager = [self setSessionManagerWithBaseURL:nil header:header];
        NSURLSessionDataTask *dataTask = [self postAPIDataTaskWithSubscriber:subscriber url:url header:header param:param];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

-(RACSignal*)patchAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.manager = [self setSessionManagerWithBaseURL:nil header:header];
        NSURLSessionDataTask *dataTask = [self patchAPIDataTaskWithSubscriber:subscriber url:url header:header param:param];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

-(RACSignal*)putAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.manager = [self setSessionManagerWithBaseURL:nil header:header];
        NSURLSessionDataTask *dataTask = [self putAPIDataTaskWithSubscriber:subscriber url:url header:header param:param];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

-(RACSignal*)deleteAPICallURL:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.manager = [self setSessionManagerWithBaseURL:nil header:header];
        NSURLSessionDataTask *dataTask = [self deleteAPIDataTaskWithSubscriber:subscriber url:url header:header param:param];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

#pragma mark - APIDataTask -

-(NSURLSessionDataTask *)getAPIDataTaskWithSubscriber:(id<RACSubscriber>)subscriber url:(NSString*)url header:(NSDictionary*)header param:(id)param {
        
    NSURLSessionDataTask *dataTask = [self.manager GET:url parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
      {
          [self responseSubscriber:subscriber responseObject:responseObject];
      }
        failure:^(NSURLSessionDataTask *task, NSError *error)
      {
          [self failureSubscriber:subscriber error:error];
      }];
    
    [[CURLLog sharedInstance] logCURLForTask:dataTask];
    
    return dataTask;
}

-(NSURLSessionDataTask *)postAPIDataTaskWithSubscriber:(id<RACSubscriber>)subscriber url:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    NSURLSessionDataTask *dataTask = [self.manager POST:url parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
      {
          [self responseSubscriber:subscriber responseObject:responseObject];
      }
        failure:^(NSURLSessionDataTask *task, NSError *error)
      {
          [self failureSubscriber:subscriber error:error];
      }];
    
    [[CURLLog sharedInstance] logCURLForTask:dataTask];
    
    return dataTask;
}

-(NSURLSessionDataTask *)patchAPIDataTaskWithSubscriber:(id<RACSubscriber>)subscriber url:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    NSURLSessionDataTask *dataTask = [self.manager PATCH:url parameters:param headers:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        [self responseSubscriber:subscriber responseObject:responseObject];
    }
      failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        [self failureSubscriber:subscriber error:error];
    }];
    
    [[CURLLog sharedInstance] logCURLForTask:dataTask];
    
    return dataTask;
}

-(NSURLSessionDataTask *)putAPIDataTaskWithSubscriber:(id<RACSubscriber>)subscriber url:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    NSURLSessionDataTask *dataTask = [self.manager PUT:url parameters:param headers:nil success:^(NSURLSessionDataTask *task, id responseObject)
      {
          [self responseSubscriber:subscriber responseObject:responseObject];
      }
        failure:^(NSURLSessionDataTask *task, NSError *error)
      {
          [self failureSubscriber:subscriber error:error];
      }];
    
    [[CURLLog sharedInstance] logCURLForTask:dataTask];
    
    return dataTask;
}

-(NSURLSessionDataTask *)deleteAPIDataTaskWithSubscriber:(id<RACSubscriber>)subscriber url:(NSString*)url header:(NSDictionary*)header param:(id)param {
    
    NSURLSessionDataTask *dataTask = [self.manager DELETE:url parameters:param headers:nil success:^(NSURLSessionDataTask *task, id responseObject)
      {
          [self responseSubscriber:subscriber responseObject:responseObject];
      }
        failure:^(NSURLSessionDataTask *task, NSError *error)
      {
          [self failureSubscriber:subscriber error:error];
      }];
    
    [[CURLLog sharedInstance] logCURLForTask:dataTask];
    
    return dataTask;
}

#pragma mark - Response Handler -

-(void)responseSubscriber:(id<RACSubscriber>)subscriber responseObject:(id)responseObject {
    
    [subscriber sendNext:responseObject];
    [subscriber sendCompleted];
}

-(void)failureSubscriber:(id<RACSubscriber>)subscriber error:(NSError *)error {
    
    [subscriber sendError:error];
    //[[CURLLog sharedInstance] logCURLForTask:task error:error];
}


#pragma mark - Progress View -

-(void)showProgressWithStatus:(NSString*)status isMask:(BOOL)isMask {
    
    [self showProgressWithStatus:status isMask:isMask fontColor:[UIColor blackColor]];
}

-(void)showProgressWithStatus:(NSString*)status isMask:(BOOL)isMask fontColor:(UIColor*)fontColor {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [SVProgressHUD setTintColor:[UIColor redColor]];
    //[SVProgressHUD setDimAmount:0.5];
    [SVProgressHUD setHUDType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader];
    
    [SVProgressHUD setForegroundColor:fontColor];
    //[SVProgressHUD setFont:[UIFont fontWithName:FontNameMedium size:14.0]];
    //[SVProgressHUD setBackgroundColor:BackGround_Color];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeDGActivity];
    [SVProgressHUD setDefaultMaskType: isMask ? SVProgressHUDMaskTypeClear : SVProgressHUDMaskTypeNone];
    [SVProgressHUD showWithStatus:status];
}

-(void)hideProgressView {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [SVProgressHUD dismiss];
        });
    });
}


@end
