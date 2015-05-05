//
//  NoteTableViewCell.m
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell



- (void)awakeFromNib {
    // Initialization code
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 0;
    self.layer.contentsScale = 20;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
