//
//  HttpClient.h
//  InfoPortal
//
//  Created by USTB on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//
/**
 * 调用方法
 - (IBAction)httpClient:(id)sender {
 NSString *url = @"http://lib.ustb.edu.cn:8080/opac/openlink.php?historyCount=0&strText=%E5%9B%B4%E5%9F%8E&doctype=ALL&strSearchType=title&match_flag=forward&displaypg=20&sort=CATA_DATE&orderby=desc&showmode=list&location=ALL";
 NSOperationQueue *queue = [[NSOperationQueue alloc] init];
 HttpClient *client = [[HttpClient alloc] initWithURLString:url];
 [queue addOperation:client];
 [client addObserver:self forKeyPath:@"isFinished" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:(__bridge void *)(client)];
 
 }
 
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
 if([keyPath isEqual:@"isFinished"]) {
 BOOL isFinished = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
 if(isFinished) {
 HttpClient *ctx = (__bridge HttpClient *)context;
 NSStringEncoding enc = NSUTF8StringEncoding;
 NSLog(@"%@", [[NSString alloc] initWithData:[ctx data] encoding:enc]);
 [ctx removeObserver:self forKeyPath:@"isFinished"];
 }
 } else {
 [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
 }
 }

 **/

#import <Foundation/Foundation.h>
#import "HttpParser.h"

@interface HttpClient : NSOperation {
    NSURLRequest* _request;
    NSURLConnection* _connection;
    NSMutableData* _data;
    NSStringEncoding enc;
}

-(id)initWithURLString: (NSString *)url;

-(NSString *) get: (NSString *)urlString: (NSDictionary *)keyValues;
-(NSString *) post: (NSString *)urlString: (NSDictionary *)keyValues;

@property(readonly) NSData *data;
@end
