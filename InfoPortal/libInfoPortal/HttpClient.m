//
//  HttpClient.m
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient
@synthesize data=_data;

-(id)initWithURLString:(NSString *)url {
    if(self = [self init]) {
        NSLog(@"%@", url);
        _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        enc = NSUTF8StringEncoding;
        _data = [[NSMutableData alloc] init];
    }
    return self;
}

-(void)start {
    if(![self isCancelled]) {
        NSLog(@"start operation");
        _connection = [NSURLConnection connectionWithRequest:_request delegate:self];
        while(_connection != nil) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    } else {
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
    }
}

-(void)connection: (NSURLConnection *)connection didReceiveData:(NSData *)data {
    HttpParser *parser = [HttpParser new];
    NSString *result = [[NSString alloc] initWithData:data encoding:enc];
    NSLog(@"connection:");
    result = [NSString stringWithFormat:@"\u57ce"];
    [parser decodeUnicode:result];
    [_data appendData:data];
    _request = nil;
    //[self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
}

-(void)connection: (NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection error");
    _request = nil;
    //[self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
}

+ (BOOL):(NSString *)key {
    if([key isEqualToString:@"isFinished"]) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

-(NSData *)request:(NSString *)urlString: (NSDictionary *)keyValues: (NSString *)methord {
    NSString *myRequestString = @"";
    for(id key in keyValues) {
        [myRequestString stringByAppendingFormat:@"&%@=%@", key, [keyValues valueForKey:key]];
    }
    NSData *myRequestData = [NSData dataWithBytes:[myRequestString UTF8String] length:[myRequestString length]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requests = [[NSMutableURLRequest alloc] initWithURL:url];
    [requests setHTTPMethod:methord];
    [requests setHTTPBody:myRequestData];
    _connection = [NSURLConnection connectionWithRequest:requests delegate:self];
    //[_connection ini];
    return [NSURLConnection sendSynchronousRequest:requests returningResponse:nil error:nil];
}

-(NSString *)get:(NSString *)urlString :(NSDictionary *)keyValues {
    return [self request:urlString :keyValues :@"get"];
}

-(NSString *)post:(NSString *)urlString :(NSDictionary *)keyValues {
    return [self request:urlString :keyValues :@"post"];
}

@end
