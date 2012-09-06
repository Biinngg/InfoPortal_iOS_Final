//
//  MapAnnotations.m
//  InfoPortal
//
//  Created by USTB on 12-9-3.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "MapAnnotations.h"

@implementation MapAnnotations
@synthesize coordinate,title,subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D)c
{
    coordinate=c;
    return self;
}

@end
