//
//  IPDatabase.h
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface IPDatabase : NSObject

-(int) open;
-(void) close;
-(int) query: (NSString *) table:(NSArray *) columns: (NSString *)selection :(NSString *) orderBy:(NSString *) limit;
-(NSArray *) moveToNext;
-(int) insert: (NSString *) table: (NSDictionary *) values : (NSString *) selection;
-(int) remove: (NSString *) table: (NSString *)selection;
-(int) update: (NSString *) table: (NSDictionary *) values : (NSString *) selection;

@end
