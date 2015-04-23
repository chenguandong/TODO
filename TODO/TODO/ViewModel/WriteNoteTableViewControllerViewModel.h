//
//  WriteNoteTableViewControllerViewModel.h
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WriteNoteTableViewControllerViewModel : NSObject

@property(nonatomic,strong)NSArray *array;

/**
 *  行数
 *
 *  @return 行数
 */
-(NSInteger)getNumberOfRowsInSection;


/**
 *  返回cell
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 *
 *  @return UITableViewCell
 */
-(UITableViewCell*)getTableViewCell:(UITableView*)tableView :(NSIndexPath*)indexPath;


/**
 *  插入note数据
 *
 *  @param noteContent Note内容
 *  @param colorNum    Note 颜色
 *
 *  @return YES 成功  NO 失败
 */
-(BOOL)insertDate:(NSString*)noteContent andNoteColor:(NSNumber*)colorNum;
@end
