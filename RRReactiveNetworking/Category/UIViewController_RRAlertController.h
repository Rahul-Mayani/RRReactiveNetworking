//
//  UIViewController_RRAlertController.h
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertCompletionBlock) (UIAlertController *alert);
typedef void (^UIActionSheetCompletionBlock) (int tag);

@interface UIViewController (UIViewController_RRAlertController)

- (void)showAlertMessage:(NSString *)message withTextView:(UITextView*)txtView;

- (void)showAlertMessage:(NSString *)message withTextField:(UITextField*)txtField;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(UIAlertCompletionBlock)handler;

@end

