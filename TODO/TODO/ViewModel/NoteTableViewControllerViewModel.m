//
//  WriteNoteTableViewControllerViewModel.m
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "NoteTableViewControllerViewModel.h"
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "NoteTableViewCell.h"
#import <NSDate+TimeAgo.h>
@implementation NoteTableViewControllerViewModel



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _array = [NSArray array];
        
         [self queryNoteData:nil];
        
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
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NoteEntity *note  = _array[indexPath.row];
    
    cell.contentLable.text = note.note_content;
    cell.dateLable.text = [note.note_create_date timeAgoSimple];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

/**
 *  查询笔记本数量
 *
 *  @param predicate 查询条件 为nil 是查询全部
 *
 *  @return 返回所有note
 */
-(NSArray*)queryNoteData :(NSPredicate*)predicate{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init]; NSEntityDescription *entity = [NSEntityDescription entityForName:noteTableName inManagedObjectContext:SharedApp.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:note_create_date ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptions];
    
    
    NSError *error;
    
    NSArray *fetchedObjects = [SharedApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    /*
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"name"]); NSManagedObject *details = [info valueForKey:@"details"]; NSLog(@"Zip: %@", [details valueForKey:@"zip"]);
    }
    */
    //查询条件
    if (predicate) {
        fetchRequest.predicate = predicate;
        _array =[fetchedObjects filteredArrayUsingPredicate:predicate];
    }else{
        _array =[fetchedObjects copy];
    }

    
    return _array;

    
}


-(void)deleteNote:(NoteEntity*)note{
   
    [SharedApp.managedObjectContext deleteObject:note];
    
    NSError *error = nil;
    if (![SharedApp.managedObjectContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

@end
