//
//  TouchIDViewController.m
//  iOS8Sampler
//
//  Created by Shuichi Tsutsumi on 2014/08/18.
//  Copyright (c) 2014 Shuichi Tsutsumi. All rights reserved.
//

#import "TouchIDViewController.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "JKLLockScreenViewController.h"
@import LocalAuthentication;


@interface TouchIDViewController ()<JKLLockScreenViewControllerDataSource, JKLLockScreenViewControllerDelegate>

@property (nonatomic, copy) NSString * enteredPincode;
@property(nonatomic,assign)BOOL isPass;
@end


@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    

    
    
    self.view.layer.contents =(__bridge id)([UIImage imageNamed:@"welcome_bg"].CGImage);
    
   
}

-(void)initCheckPassCode{
    
    
    
    _enteredPincode = (NSString*)[[NSUserDefaults standardUserDefaults]valueForKey:DTpincode];
    
    NSLog(@"%@",_enteredPincode);
    
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:passLock]) {
        
        JKLLockScreenViewController *viewController = [[JKLLockScreenViewController alloc] initWithNibName:NSStringFromClass([JKLLockScreenViewController class]) bundle:nil];
        [viewController setLockScreenMode:LockScreenModeNormal];    // enum { LockScreenModeNormal, LockScreenModeNew, LockScreenModeChange }
        [viewController setDelegate:self];
        [viewController setDataSource:self];
        
        [self presentViewController:viewController animated:YES completion:NULL];
        //        [viewController willMoveToParentViewController:self];
        //        [self addChildViewController:viewController];
        //        viewController.view.frame = self.view.frame;
        //        [self.view addSubview:viewController.view];
        //        [viewController didMoveToParentViewController:self];
        
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    if (_isPass||![[NSUserDefaults standardUserDefaults]boolForKey:passLock]) {
        [self performSegueWithIdentifier:@"Touch" sender:self];
        return;
    }
     [self initCheckPassCode];
   
}

-(void)initCheckTouchID{
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

#pragma mark -
#pragma mark YMDLockScreenViewControllerDelegate
- (void)unlockWasCancelledLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController {
    
    NSLog(@"LockScreenViewController dismiss because of cancel");
}

- (void)unlockWasSuccessfulLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode {
    
    self.enteredPincode = pincode;
}

#pragma mark -
#pragma mark YMDLockScreenViewControllerDataSource
- (BOOL)lockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode {
    
#ifdef DEBUG
    NSLog(@"Entered Pincode : %@", self.enteredPincode);
#endif
    
    _isPass =[self.enteredPincode isEqualToString:pincode];
    
    
    return _isPass;
}

- (BOOL)allowTouchIDLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController {
    
    return YES;
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
