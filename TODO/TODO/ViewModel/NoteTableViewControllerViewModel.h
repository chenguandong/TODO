//
//  WriteNoteTableViewControllerViewModel.h
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NoteEntity.h"
@interface NoteTableViewControllerViewModel : NSObject

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
 *  查询笔记本数量
 *
 *  @param predicate 查询条件 为nil 是查询全部
 *
 *  @return 返回所有note
 */
-(NSArray*)queryNoteData :(NSPredicate*)predicate;

/**
 *  删除note
 *
 *  @param note note实体
 */
-(void)deleteNote:(NoteEntity*)note;
@end
