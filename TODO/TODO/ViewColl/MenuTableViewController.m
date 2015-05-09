//
//  MenuTableViewController.m
//  TODO
//
//  Created by chenguandong on 15/4/30.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "MenuTableViewController.h"
#import "JKLLockScreenViewController.h"
#import "Constants.h"
@import LocalAuthentication;
@interface MenuTableViewController ()<JKLLockScreenViewControllerDataSource, JKLLockScreenViewControllerDelegate>
@property (nonatomic, strong) NSString * enteredPincode;
@property(nonatomic,strong) NSUserDefaults *userDefault;
@end

@implementation MenuTableViewController


-(void)dealloc{
    _userDefault = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userDefault = [NSUserDefaults standardUserDefaults];
    
    [_passWordSwitchView setOn:[_userDefault boolForKey:passLock] animated:YES];
    [_TouchSwitchView setOn:[_userDefault boolForKey:touchLock] animated:YES];
    [_nightSwitch setOn:[_userDefault boolForKey:isNight]];
    
    [self checkTouchID];
    
    //下面代码是针对ipad 背景没有透明的处理
    _cell1.backgroundColor =[UIColor clearColor];
    _cell2.backgroundColor =[UIColor clearColor];
}


/**
 *  检测是否支持指纹识别
 */
-(void)checkTouchID{
    
    LAContext *context = [[LAContext alloc] init];
    
    
    NSError *error;
    
    // check if the policy can be evaluated
    if (![context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        _cell1.hidden = YES;
        return;
    }
}


- (IBAction)changeState:(id)sender {
    
    
    UISwitch *swith ;
    if ([sender isKindOfClass:[UISwitch class]]) {
        swith =(UISwitch*)sender;

    }

    
    switch ([sender tag]) {
        case 0:
            
            [_userDefault setBool:swith.isOn forKey:touchLock];
            
            [_userDefault synchronize];
            
           
            
            break;
        case 1:
        {
            [_userDefault setBool:swith.isOn forKey:passLock];
            
            [_userDefault synchronize];
            
            if ([swith isOn]) {
                JKLLockScreenViewController *viewController = [[JKLLockScreenViewController alloc] initWithNibName:NSStringFromClass([JKLLockScreenViewController class]) bundle:nil];
                [viewController setLockScreenMode:[sender tag]];    // enum { LockScreenModeNormal, LockScreenModeNew, LockScreenModeChange }
                [viewController setDelegate:self];
                [viewController setDataSource:self];
                
                
               
                
                [self presentViewController:viewController animated:YES completion:NULL];
                
                
               
            }

        
            
        }
            break;
            
            
        case 2://是否开启夜间模式
            [_userDefault setBool:swith.isOn forKey:isNight];
            [_userDefault synchronize];
            
            //发送切换主题广播
            
            [[NSNotificationCenter defaultCenter]postNotificationName:isNightNotificationCenter object:nil];
           
            
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark YMDLockScreenViewControllerDelegate
- (void)unlockWasCancelledLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController {
    
    NSLog(@"LockScreenViewController dismiss because of cancel");
}

- (void)unlockWasSuccessfulLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode {
    
    self.enteredPincode = pincode;
    
   
    [_userDefault setBool:YES forKey:passLock];
    
    
    NSLog(@"%@",_enteredPincode);
    

    [_userDefault setObject:_enteredPincode forKey:DTpincode];
    [_userDefault synchronize];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:DTpincode]);
}

#pragma mark -
#pragma mark YMDLockScreenViewControllerDataSource
- (BOOL)lockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController pincode:(NSString *)pincode {
    
#ifdef DEBUG
    NSLog(@"Entered Pincode : %@", self.enteredPincode);
#endif
    
    return [self.enteredPincode isEqualToString:pincode];
}

- (BOOL)allowTouchIDLockScreenViewController:(JKLLockScreenViewController *)lockScreenViewController {
    
    return YES;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
