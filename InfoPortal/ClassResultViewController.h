//
//  ClassResultViewController.h
//  InfoPortal
//
//  Created by Tcat on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "libInfoPortal/ClassDatabase.h"
#import "UserChoosedData.h"
#import "ClassTableView.h"

@interface ClassResultViewController : UIViewController
{
    NSMutableArray *myResultData;
    StructResult *myResult;
    ClassDatabase *myDatabase;
    UserChoosedData *myUserData;
    ClassTableView *myClassTableView;
}
@property (weak, nonatomic) IBOutlet UIScrollView *myView;
@property (weak, nonatomic) IBOutlet UIView *MainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil:(UserChoosedData *)data:(ClassDatabase *)db;
@end
