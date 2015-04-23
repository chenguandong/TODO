//
//  WriteNoteTableViewControllerViewModel.m
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WriteNoteTableViewControllerViewModel.h"
#import <CoreData/CoreData.h>
#import "NoteEntity.h"
#import "Constants.h"
@implementation WriteNoteTableViewControllerViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSArray array];
    }
    return self;
}
/**
 *  行数
 *
 *  @return 行数
 */
-(NSInteger)getNumberOfRowsInSection{
    
    return _array.count;
}


/**
 *  返回cell
 *
 *  @param tableView tableview
 *  @param indexPath indexPath
 *
 *  @return UITableViewCell
 */
-(UITableViewCell*)getTableViewCell:(UITableView*)tableView :(NSIndexPath*)indexPath{

    return nil;
}


-(BOOL)insertDate:(NSString*)noteContent andNoteColor:(NSNumber*)colorNum{
    NSManagedObjectContext *context = SharedApp.managedObjectContext;
    NoteEntity *noteModel = [NSEntityDescription
                                       insertNewObjectForEntityForName:noteTableName
                                       inManagedObjectContext:context];
    noteModel.note_color = colorNum;
    noteModel.note_content = noteContent;
    noteModel.note_create_date = [NSDate date];
    noteModel.note_delete_date = nil;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }else{
        return YES;
    }
    
}


@end
