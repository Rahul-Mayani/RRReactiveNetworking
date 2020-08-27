

#import <Foundation/Foundation.h>

@interface NSURLRequest (CURL)
- (NSString*)curl;
- (NSString*)curlVerbose:(BOOL)verbose;
@end
