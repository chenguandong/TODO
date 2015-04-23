//
//  NoteEntity.h
//  
//
//  Created by chenguandong on 15/4/23.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteEntity : NSManagedObject

@property (nonatomic, retain) NSDate * note_create_date;
@property (nonatomic, retain) NSString * note_content;
@property (nonatomic, retain) NSDate * note_delete_date;
@property (nonatomic, retain) NSNumber * note_color;

@end
