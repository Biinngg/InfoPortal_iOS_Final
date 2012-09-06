//
//  ClassDatabase.h
//  InfoPortal
//
//  Created by USTB on 12-8-28.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPDatabase.h"
#import "StructBuild.h"
#import "StructUsage.h"
#import "StructResult.h"
#import "IPDate.h"
/**
 * 用于为ClassView提供数据库访问方法。
 **/
@interface ClassDatabase : NSObject

/**
 * 获得教学楼名，返回NSString数组.
 **/
-(NSArray *) getBuild;
/**
 * 获得教学楼名
 **/
-(NSString *) getBuildName: (int) buildId;
/**
 * 获得楼层数量
 **/
-(int) getFloor: (int) buildId;
/**
 * 获得节次
 **/
-(NSArray *) getTimes;
/**
 * 获取开学时间
 **/
-(long) getTermStart;
/**
 * 获取学期结束时间
 **/
-(long) getTermEnd;
/**
 * 获取第几周
 **/
-(int) getWeekNum: (long) curTimeStamp;
/**
 * 获得连续几天的教室使用状况
 **/
-(NSArray *) getUsage:(int) buildId: (int) roomNum: (long) startTimeStamp : (int) days;
/**
 * 获得教室搜索结果
 **/
-(NSArray *) getResult: (long) buildSelect: (int) floorFrom: (int)floorTo: (int) timesFrom: (int)timesTo: (long) timeStamp;

@end
