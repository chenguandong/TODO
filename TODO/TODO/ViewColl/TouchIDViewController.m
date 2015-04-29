//
//  TouchIDViewController.m
//  iOS8Sampler
//
//  Created by Shuichi Tsutsumi on 2014/08/18.
//  Copyright (c) 2014 Shuichi Tsutsumi. All rights reserved.
//

#import "TouchIDViewController.h"
#import "SVProgressHUD.h"
@import LocalAuthentication;


@interface TouchIDViewController ()

@end


@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.layer.contents =(__bridge id)([UIImage imageNamed:@"welcome_bg"].CGImage);
    
    LAContext *context = [[LAContext alloc] init];
    

    NSError *error;
    
    // check if the policy can be evaluated
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        NSLog(@"error:%@", error);
        NSString *msg = [NSString stringWithFormat:@"Can't evaluate policy! %@", error.localizedDescription];
        [SVProgressHUD showErrorWithStatus:msg];
        return;
    }
    
    // evaluate
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:@"请验证已有指纹"
                      reply:
     ^(BOOL success, NSError *authenticationError) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (success) {
                // [SVProgressHUD showSuccessWithStatus:@"验证成功"];
                 
                 [self performSegueWithIdentifier:@"Touch" sender:self];
                 
                 
             }
             else {
                 NSLog(@"error:%@", authenticationError);
                 [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"验证失败,请重新验证"]];
             }
         });
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
