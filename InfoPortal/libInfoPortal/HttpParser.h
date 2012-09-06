//
//  HttpParser.h
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParser : NSObject

-(NSString *) decodeUnicode: (NSString *) dataStr;

-(NSString *) searchAllReplace: (NSString *) inString: (NSString *)src: (NSString *)dest;

-(int) hexToInt: (NSString *)hexNumber;

@end
