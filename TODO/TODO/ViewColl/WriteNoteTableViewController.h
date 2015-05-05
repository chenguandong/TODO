//
//  WriteNoteTableViewController.h
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"
#import <RFMarkdownTextView.h>
@interface WriteNoteTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet RFMarkdownTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor1;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor2;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor3;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor4;
@property (weak, nonatomic) IBOutlet UIButton *buttonColor5;

@property(nonatomic,strong)NoteEntity *noteModel;
@end
