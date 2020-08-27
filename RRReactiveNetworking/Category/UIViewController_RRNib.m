//
//  UIViewController_RRNib.m
//  RRReactiveNetworking
//
//  Created by Rahul Mayani on 26/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

#import "UIViewController_RRNib.h"
#import "UINavigationController_RRRoot.h"

@implementation UIViewController (UIViewController_RRNib)

+(id)initWithNib {
    
    return  [[self alloc] initWithNibName:NSStringFromClass([self class])  bundle:nil];
}

-(UIViewController*)getControllerInNavigationHierarchy:(UIViewController*)vc {
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[vc class]])
        {
            return controller;
            break;
        }
    }
    return nil;
}

//

-(void)presentVC:(UIViewController*)vc animated:(BOOL)animated
{
    [self presentViewController:[UINavigationController initWithRootVC:vc] animated:animated completion:nil];
}

-(void)pushVC:(UIViewController*)vc animated:(BOOL)animated
{
    [self.navigationController pushViewController:vc animated:animated];
}
-(void)popVC:(UIViewController*)vc animated:(BOOL)animated
{
    [self.navigationController popToViewController:vc animated:YES];
}
//

-(void)dismissVCAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:animated completion:nil];
}

-(void)popVCAnimated:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:animated];
}

-(void)popToRootVCAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

-(void)popToVC:(UIViewController*)vc animated:(BOOL)animated
{
    [self.navigationController popToViewController:vc animated:animated];
}

// MARK: - Button Action -

// Back method
- (IBAction)btnBack:(id)sender {
    [self popVCAnimated:YES];
}

@end
