//
//  IPDatabase.m
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "IPDatabase.h"

@implementation IPDatabase {
    sqlite3 *database;
    sqlite3_stmt *statement;
    int columnSize;
}

-(int) open {
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"infoportal.db" ];
    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        return 1;
    } else {
        return 0;
    }
}

-(void) close {
    sqlite3_close(database);
}

-(int) query:(NSString *)table:(NSArray *)columns :(NSString *) selection :(NSString *)orderBy :(NSString *)limit {
    columnSize = [columns count];
    NSString *selectSql = @"select ";
    if(columns == nil)
        selectSql = [selectSql stringByAppendingString:@" * "];
    else {
        for(NSString *column in columns) {
            selectSql = [selectSql stringByAppendingString:column];
            selectSql = [selectSql stringByAppendingString:@", "];
        }
        selectSql = [selectSql substringToIndex:[selectSql length] - 2];
    }
    selectSql = [selectSql stringByAppendingString:@" from "];
    selectSql = [selectSql stringByAppendingString:table];
    if(selection != nil) {
        selectSql = [selectSql stringByAppendingString:@" where "];
        selectSql = [selectSql stringByAppendingString:selection];
    }
    if(orderBy != nil) {
        selectSql = [selectSql stringByAppendingString:@" order by "];
        selectSql = [selectSql stringByAppendingString:orderBy];
    }
    if(limit != nil) {
        selectSql = [selectSql stringByAppendingString:@" limit "];
        selectSql = [selectSql stringByAppendingString:limit];
    }
    selectSql = [selectSql stringByAppendingString:@";"];
    const char *sqlSentence = [selectSql UTF8String];
    NSLog(@"sqlSentence: %s", sqlSentence);
    if(sqlite3_prepare_v2(database, sqlSentence, -1, &statement, nil) == SQLITE_OK) {
        NSLog(@"query success");
        return 1;
    } else {
        NSLog(@"query fail");
        return 0;
    }
}

-(NSArray *) moveToNext {
    NSMutableArray *array;
    array = [[NSMutableArray alloc] init];
    if(sqlite3_step(statement) == SQLITE_ROW) {
        for(int i=0; i<columnSize; i++) {
            NSLog(@"moveToNext i=%d", i);
            const unsigned char *result = sqlite3_column_text(statement, i);
            NSString *resultStr = @"";
            if(result != nil)
                resultStr = [NSString stringWithUTF8String:result];
            [array addObject:resultStr];
            NSLog(@"moveToNext result=%@", resultStr);
        }
        return array;
    } else
        return nil;
}

@end
