//
//  WriteNoteTableViewController.h
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"

@interface WriteNoteTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)NoteEntity *noteModel;
@end
