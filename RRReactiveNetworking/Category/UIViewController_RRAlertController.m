//
//  UIViewController_RRAlertController.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "UIViewController_RRAlertController.h"
#import "RRApiManager.h"
#import "Constants.h"

@implementation UIViewController (UIViewController_RRAlertController)

- (void)showAlertMessage:(NSString *)message withTextView:(UITextView*)txtView {
    
    [RRApiManagerShared hideProgressView];
    [self.view endEditing:YES];
    [self showAlertWithTitle:@"" message:message handler:^(UIAlertController *alert) {
        [txtView becomeFirstResponder];
    }];
}

- (void)showAlertMessage:(NSString *)message withTextField:(UITextField*)txtField {
    
    [RRApiManagerShared hideProgressView];
    [self.view endEditing:YES];
    [self showAlertWithTitle:@"" message:message handler:^(UIAlertController *alert) {
        [txtField becomeFirstResponder];
    }];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    if (isEmpty(title) && isEmpty(message)) {
        message = @"Communication error";
    }
    [RRApiManagerShared hideProgressView];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            // OK button tappped.
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
   
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(UIAlertCompletionBlock)handler {
    
    if (isEmpty(title) && isEmpty(message)) {
        message = @"Communication error";
    }
    [RRApiManagerShared hideProgressView];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // OK button tappped.
        handler(alertController);
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
