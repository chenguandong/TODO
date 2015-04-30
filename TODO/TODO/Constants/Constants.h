//
//  Constants.h
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define SharedApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

UIKIT_EXTERN NSString *const noteTableName;


UIKIT_EXTERN NSString *const note_create_date;
UIKIT_EXTERN NSString *const note_content;
UIKIT_EXTERN NSString *const note_delete_date;
UIKIT_EXTERN NSString *const note_color;

//NSUserDefault property name
UIKIT_EXTERN NSString *const passLock;
UIKIT_EXTERN NSString *const DTpincode;