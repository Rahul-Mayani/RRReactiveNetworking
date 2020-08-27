

#import <Foundation/Foundation.h>

@interface CURLLog : NSObject

typedef NS_ENUM(NSUInteger, CURLLogOutputType) {
    CURLLogOutputTypeNone,
    CURLLogOutputTypePrettyPBCopy,
    CURLLogOutputTypePretty,
    CURLLogOutputTypePBCopy,
};


@property (nonatomic) CURLLogOutputType outputType;
+ (CURLLog*)sharedInstance;

-(void)logCURLForTask:(NSURLSessionTask*)task;
-(void)logCURLForTask:(NSURLSessionTask*)task payload:(id)payload;
-(void)logCURLForTask:(NSURLSessionTask*)task error:(NSError*)error;

-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response;
-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response payload:(id)payload;
-(void)logCURLRequest:(NSURLRequest*)request response:(NSURLResponse*)response error:(NSError*)error;

@end
