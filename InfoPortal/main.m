//
//  main.m
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "libInfoPortal/Initialize.h"

int main(int argc, char *argv[])
{
    Initialize *myInit=[Initialize new];
    [myInit checkAndCopy];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
