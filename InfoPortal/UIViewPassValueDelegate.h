//
//  UIViewPassValueDelegate.h
//  InfoPortal
//
//  Created by USTB on 12-9-1.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

@protocol UIViewPassValueDelegate

-(void)getdate:(NSDate *)date;
-(void)getnumber:(NSString *)data:(int)number;
-(void)resetSearchButton;

@end
