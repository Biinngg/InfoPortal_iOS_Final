//
//  HttpParser.m
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "HttpParser.h"

@implementation HttpParser

-(NSString *) decodeUnicode:(NSString *)dataStr {
    dataStr = [self searchAllReplace:dataStr :@"&#x" :@"\\u"];
    NSString *buffer = @"";
    NSString *tempStr = @"";
    NSString *operStr = dataStr;
    int index = [operStr rangeOfString:@"\\u"].location;
    NSLog(@"\nindex %d\nlength %d", index, [dataStr length]);
    if(operStr != nil && index == NSNotFound)
        return [buffer stringByAppendingString:operStr];
    if(operStr != nil && [operStr length] != 0 && index != 0 ) {
        NSLog(@"arrive while");
        tempStr = [operStr substringToIndex:index];
        NSLog(@"\ntempStr %@", tempStr);
        operStr = [operStr substringFromIndex:index];
        NSLog(@"\nindex %d\ntempStr %@\noperStr %@", index, tempStr, operStr);
    }
    [buffer stringByAppendingString:tempStr];
    index = [operStr rangeOfString:@"\\u"].location;
    while (operStr != nil && [operStr length] != 0 && index == 0) {
        NSLog(@"arrive while");
        tempStr = [operStr substringToIndex:6];
        NSLog(@"\ntempStr %@", tempStr);
        operStr = [operStr substringFromIndex:7];
        NSLog(@"\nindex %d\ntempStr %@\noperStr %@", index, tempStr, operStr);
        NSString *charStr;
        charStr = [tempStr substringFromIndex:2];
        char letter = (char) [self hexToInt:charStr];
        NSCharacterSet *character = [NSCharacterSet new];
        NSLog(@"\u65e0\u654c\u6d5a\u6d5a");
        NSLog(@"letter %c",letter);
        NSLog(@"utf8letter %@",[NSString stringWithCharacters:letter length:8]);
        [buffer stringByAppendingString:[NSString stringWithCString:&letter encoding:NSUTF8StringEncoding]];
        NSLog(@"\nbuffer %@", buffer);
        index = [operStr rangeOfString:@"\\u"].location;
        if(index == NSNotFound) {
            [buffer stringByAppendingString:operStr];
        } else {
            tempStr = [operStr substringToIndex:index];
            operStr = [operStr substringFromIndex:index];
            [buffer stringByAppendingString:tempStr];
            NSLog(@"\nindex %d\ntempStr %@\noperStr %@", index, tempStr, operStr);
        }
    }
    return buffer;
}

-(NSString *) searchAllReplace:(NSString *)inString :(NSString *)src :(NSString *)dest {
    NSMutableString *mstr = [NSMutableString stringWithString:inString];
    NSRange substr = [inString rangeOfString:src];
    while(substr.location != NSNotFound) {
        [mstr replaceCharactersInRange:substr withString:dest];
        substr = [mstr rangeOfString:src];
    }
    return mstr;
}

-(int) hexToInt:(NSString *)hexNumber {
    int length = [hexNumber length];
    int result = 0;
    for(int i=0;i<length;i++) {
        char hex_char = [hexNumber characterAtIndex:i];
        if(hex_char < 58) {
            result = (result + (hex_char - 48)) * 16;
        } else {
            result = (result + (hex_char - 87)) * 16;
        }
    }
    result /= 16;
    NSLog(@"hextoinx result %d", result);
    return result;
}

@end
