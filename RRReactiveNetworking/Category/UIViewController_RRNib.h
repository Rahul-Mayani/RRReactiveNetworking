//
//  UIViewController_RRNib.h
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UIViewController_RRNib)

+(id)initWithNib;

-(UIViewController*)getControllerInNavigationHierarchy:(UIViewController*)vc;

////

-(void)presentVC:(UIViewController*)vc animated:(BOOL)animated;
-(void)pushVC:(UIViewController*)vc animated:(BOOL)animated;
-(void)popVC:(UIViewController*)vc animated:(BOOL)animated;
////

-(void)dismissVCAnimated:(BOOL)animated;
-(void)popVCAnimated:(BOOL)animated;
-(void)popToRootVCAnimated:(BOOL)animated;
-(void)popToVC:(UIViewController*)vc animated:(BOOL)animated;

// Back action method
- (IBAction)btnBack:(id)sender;

@end
