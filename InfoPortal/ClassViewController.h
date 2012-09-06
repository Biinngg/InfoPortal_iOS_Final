//
//  ClassViewController.h
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import "ClassViewController.h"
#import "TimePickerView.h"
#import "ChooseView.h"
#import "UIViewPassValueDelegate.h"
#import "MapView.h"
#import "UserChoosedData.h"
#import "libInfoPortal/ClassDatabase.h"
#import "ClassResultViewController.h"
@interface ClassViewController : UIViewController<UIViewPassValueDelegate>
{
    TimePickerView *myTimePickerView;
    ChooseView *myChooseView_1;
    ChooseView *myChooseView_2;
    ChooseView *myChooseView_3;
    ChooseView *myChooseView_4;
    MapView *myMapView;
    UserChoosedData *myUserData;
    NSDate *choosedate;
    NSArray *ListData;
    NSArray *Building;
    NSDateFormatter *TimeNow;
    StructBuild *myBuild;
    long mychoosedBuildingID;
    NSArray *Floors;
    NSMutableArray *Button;
    IBOutlet UIButton *ButtonSender;
    @public
    ClassDatabase *myDatabase;
    IPDate *myIPDate;
    UIAlertView *myAlertView;
    ClassResultViewController *myResultViewController;
}
@property (weak, nonatomic) IBOutlet UIButton *FromClassButton;
@property (weak, nonatomic) IBOutlet UIButton *ToClassButton;
@property (strong, nonatomic) IBOutlet UILabel *Wronglabel;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) IBOutlet UIView *myView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *mySearchButton;
@property (nonatomic,retain) NSDate *choosedate;
@property (nonatomic,retain) TimePickerView *myTimePickerView;
@property (nonatomic,retain) ChooseView *myChooseView_1;
@property (nonatomic,retain) ChooseView *myChooseView_2;
@property (nonatomic,retain) ChooseView *myChooseView_3;
@property (nonatomic,retain) ChooseView *myChooseView_4;
@property (nonatomic,retain) MapView *myMapView;
@property (nonatomic,retain) NSArray *ListData;
@property (nonatomic,retain) NSArray *Building;
@property (nonatomic,retain) NSMutableArray *Button;
@property (nonatomic,retain) UIButton *ButtonSender;
@property (weak, nonatomic) IBOutlet UIButton *DateButton;
-(IBAction)ClickButton:(id)sender;
-(IBAction)ChooseBuilding:(id)sender;
- (IBAction)NextButton:(id)sender;

@end
