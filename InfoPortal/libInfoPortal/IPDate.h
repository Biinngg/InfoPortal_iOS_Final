//
//  IPDate.h
//  InfoPortal
//
//  Created by Liu Bing on 12-8-31.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPDate : NSObject

-(long)timeToStamp: (NSString *) date: (NSString *) format;

-(NSString *)getWeekName: (long)timeStamp;

@end
