//
//  Constants.h
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */


/**
 *  Shared Delegate
 */

#define AppDel ((AppDelegate*)CSharedApplication.delegate)

/**
 *  Shared RootViewController
 */

#define AppRoot (CSharedApplication.keyWindow.rootViewController)

/*  isEmpty Validation  */

inline static BOOL isEmpty(id object)
{
    return object == nil
    || [object isKindOfClass:[NSNull class]]
    || ([object respondsToSelector:@selector(length)]
        && [(NSData *)object length] == 0)
    || ([object respondsToSelector:@selector(count)]
        && [(NSArray *)object count] == 0);
}
