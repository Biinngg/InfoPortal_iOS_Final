//
//  ClassTableView.h
//  InfoPortal
//
//  Created by Tcat on 12-9-5.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "libInfoPortal/ClassDatabase.h"
#import "UserChoosedData.h"
@interface ClassTableView : UIView
{
    UIView *alertShowView;
    UIView *background;
    NSArray *myData;
    long myTime;
    ClassDatabase *myDatabase;
    UIButton *mySender;
    StructUsage *myUsage;
    CGPoint gest;
}
@property (weak, nonatomic) IBOutlet UIView *myView;
@property CGPoint gest;
- (id)initWithSuperView:(UIView *)superView:(ClassDatabase *)db:(long) time:(UIButton *)Sender;
-(void)loadView:(UIView *)superView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@end
