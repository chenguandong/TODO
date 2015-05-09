//
//  MenuTableViewController.h
//  TODO
//
//  Created by chenguandong on 15/4/30.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *TouchSwitchView;
@property (weak, nonatomic) IBOutlet UISwitch *passWordSwitchView;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UISwitch *nightSwitch;

@end
