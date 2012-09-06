//
//  ClassDatabase.m
//  InfoPortal
//
//  Created by USTB on 12-8-28.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassDatabase.h"

@implementation ClassDatabase {
    int classNumber;
    long termStartStamp;
}

-(id) init {
    self = [super init];
    if(self) {
        classNumber = 0;
        termStartStamp = 0;
    }
    return self;
}

-(NSArray *) getBuild {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithObjects:@"_id", @"name", @"location", nil];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_build" :array :nil :@"floor_num DESC" :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while([next count] != 0) {
            StructBuild *build = [StructBuild new];
            build->buildId = [[next objectAtIndex:0] integerValue];
            build->buildName = [next objectAtIndex:1];
            build->location = [next objectAtIndex:2];
            [result addObject:build];
            next = [database moveToNext];
        }
    }
    [database close];
    return result;
}

-(NSString *) getBuildName: (int) buildId {
    NSString *result;
    IPDatabase *database = [IPDatabase new];
    [database open];
    NSString *condition = [NSString stringWithFormat:@"_id=%d", buildId];
    NSArray *columns = [[NSArray alloc] initWithObjects:@"name", nil];
    int status = [database query:@"cla_build" :columns :condition :nil :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        result = [next objectAtIndex:0];
    }
    [database close];
    return result;
}

-(int) getFloor:(int)buildId {
    int floorNum;
    NSString *condition = @"_id = ";
    condition = [condition stringByAppendingFormat:@"%d",buildId];
    NSLog(@"condition: %@", condition);
    NSArray *array = [NSArray arrayWithObject:@"floor_num"];
    IPDatabase *database = [IPDatabase alloc];
    [database open];
    int status = [database query:@"cla_build":array:condition:nil:nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        floorNum = [[next objectAtIndex:0] integerValue];
    }
    [database close];
    return floorNum;
}

-(NSArray *)getTimes {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
    NSString *condition = @"period=1";
    NSArray *array = [NSArray arrayWithObject:@"name"];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_time":array:condition:nil:nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while([next count] != 0) {
            [result addObject:[next objectAtIndex:0]];
            next = [database moveToNext];
        }
    }
    classNumber = [result count];
    [database close];
    return result;
}

-(long)getTermTime: (NSString *) column {
    long result;
    IPDate *date = [IPDate new];
    NSString *condition = @"_id=1";
    NSArray *array = [NSArray arrayWithObject:column];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:@"cla_time" :array :condition :nil :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        NSLog(@"getTermStart %@", [next objectAtIndex:0]);
        result = [date timeToStamp:[next objectAtIndex:0] :@"YYYYMMdd"];
    }
    [database close];
    return result;
}

-(long)getTermStart {
    termStartStamp = [self getTermTime:@"begin"];
    return termStartStamp;
}

-(long)getTermEnd {
    NSLog(@"getTermEnd");
    return [self getTermTime:@"end"];
}

-(int) getWeekNum:(long)curTimeStamp {
    if(termStartStamp == 0)
        [self getTermStart];
    long weekNum = (curTimeStamp - termStartStamp) / 604800;
    return weekNum;
}

-(NSArray *)getUsage:(int) buildId: (int) roomNum: (long)startTimeStamp :(int)days {
    NSMutableArray *result;
    result = [[NSMutableArray alloc] init];
    NSString *condition = [NSString stringWithFormat:@"build=%d and room=%d", buildId, roomNum];
    if(classNumber == 0)
        [self getTimes];
    NSMutableArray *columns;
    columns = [[NSMutableArray alloc] init];
    for(int i=0; i<classNumber; i++) {
        NSString *str = [NSString stringWithFormat:@"class%d", (i+1)];
        [columns addObject:str];
    }
    IPDatabase *database = [IPDatabase new];
    [database open];
    IPDate *date = [IPDate new];
    for(int i=0;i<days;i++) {
        StructUsage *usage = [StructUsage new];
        long stamp = startTimeStamp + i * 86400;
        NSString *weekName = [date getWeekName:stamp];
        int weekNum = [self getWeekNum:stamp];
        [database query:weekName :columns :condition :nil :nil];
        NSArray *next = [database moveToNext];
        NSMutableArray *status;
        status = [[NSMutableArray alloc] init];
        for(int j=0; j<classNumber; j++) {
            int value = [[next objectAtIndex:j] integerValue] & (1 << weekNum);
            if(value != 0)
                value = 1;
            [status addObject:[NSString stringWithFormat:@"%d", value]];
        }
        usage->timeStamp = stamp;
        usage->usageStatus = status;
        [result addObject:usage];
    }
    [database close];
    return result;
}

-(NSArray *) getResult:(long)buildSelect :(int)floorFrom: (int)floorTo:(int)timesFrom: (int)timesTo:(long)timeStamp {
    if(floorFrom > floorTo) {
        int tmp = floorFrom;
        floorFrom = floorTo;
        floorTo = tmp;
    }
    if(timesFrom > timesTo) {
        int tmp = timesFrom;
        timesFrom = timesTo;
        timesTo = tmp;
    }
    int roomFrom = floorFrom * 100;
    int roomTo = (floorTo + 1) * 100;
    int weekNum = [self getWeekNum:timeStamp];
    NSLog(@"weekNum=%d", weekNum);
    int binWeekNum = 1 << weekNum;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *array = [NSArray arrayWithObjects:@"build", @"room", nil];
    int n=1;
    NSString *condition = @"(";
    for(int i=1;i<=buildSelect;i=i<<1) {
        if((i&buildSelect) != 0) {
            StructResult *structResult = [StructResult new];
            structResult->buildId = n;
            structResult->roomName = [[NSMutableArray alloc] init];
            [result addObject: structResult];
            condition = [condition stringByAppendingFormat:@"build=%d or " , n];
        }
        n++;
    }
    condition = [condition substringToIndex:([condition length]-3)];
    condition = [condition stringByAppendingFormat:@")and room>%d and room<%d ", roomFrom, roomTo];
    for(int time = timesFrom; time <= timesTo; time++) {
        condition = [condition stringByAppendingFormat:@"and class%d & %d = %d ", time, binWeekNum, binWeekNum];
    }
    IPDate *date = [IPDate new];
    NSString *weekName = [date getWeekName:timeStamp];
    IPDatabase *database = [IPDatabase new];
    [database open];
    int status = [database query:weekName :array :condition :nil :nil];
    if(status == 1) {
        NSArray *next = [database moveToNext];
        while([next count] != 0) {
            int value = [[next objectAtIndex:0] integerValue];
            for(int i=0;i<[result count];i++) {
                StructResult *sr = [result objectAtIndex:i];
                if(sr->buildId == value) {
                    [sr->roomName addObject:[next objectAtIndex:1]];
                }
            }
            next = [database moveToNext];
        }
    }
    [database close];
    return result;
}

@end
