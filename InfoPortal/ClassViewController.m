//
//  ClassViewController.m
//  InfoPortal
//
//  Created by USTB on 12-8-27.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ClassViewController ()

@end

@implementation ClassViewController
@synthesize FromClassButton;
@synthesize ToClassButton;
@synthesize Wronglabel;
@synthesize myScrollView;
@synthesize myView;
@synthesize mySearchButton;
@synthesize myTimePickerView,myChooseView_1,myChooseView_2,myChooseView_3,myChooseView_4,myMapView,ListData,ButtonSender,Building,Button,choosedate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)resetBuildingButton
{
    int i;
    for (i=0;i<[Building count];i++)
    {
        if(((mychoosedBuildingID>>i)&1)==1)
        {
            [[Button objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"Click"] forState:UIControlStateNormal];
        }
        else
        {
            [[Button objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"unClick"] forState:UIControlStateNormal];
        }
    }
}
-(IBAction)ChooseBuilding:(id)sender
{
    Wronglabel.hidden=true;
    if(((mychoosedBuildingID>>([sender tag]-500))&1)==1)
    {
        mychoosedBuildingID=mychoosedBuildingID&(~(1<<([sender tag]-500)));
    }
    else
    {
        mychoosedBuildingID=mychoosedBuildingID|(1<<([sender tag]-500));
        
    }
    [self resetBuildingButton];
    [self initFloor];
}
- (IBAction)NextButton:(id)sender
{
    myUserData->choosedBuildingID=[self resetBuildID:mychoosedBuildingID];
    if ([self checkFloor])
    {
        switch ([self checkTime])
        {
            case 2:
                myAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您选择的时间为周六日，不在查询范围之内" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [myAlertView show];
                break;
            case 1:
                myAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您选择的时间不在查询范围之内" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [myAlertView show];
                break;
                
            default:
                myResultViewController=[[ClassResultViewController alloc]initWithNibName:@"ClassResultViewController" bundle:nil :myUserData:myDatabase];
                [self.navigationController pushViewController:myResultViewController animated:YES];
                break;
        }
    }
}
-(void)getdate:(NSDate *)date
{
    myUserData->choosedDate=[date timeIntervalSince1970];
    date=[date dateByAddingTimeInterval:3600*24];
    NSString *da=[[[NSString alloc] initWithFormat:@"%@",date]substringToIndex:10];
    [self.DateButton setTitle:da forState:UIControlStateNormal];
}
-(void)getnumber:(NSString *)data:(int)number
{
    [self.ButtonSender setTitle:data forState:UIControlStateNormal];
    switch ([ButtonSender tag]) {
        case 1:myUserData->choosedFloorFromID=number;
            break;
        case 2:myUserData->choosedFloorToID=number;
            break;
        case 3:myUserData->choosedClassFromID=number;
            break;
        case 4:myUserData->choosedClassToID=number;
            break;            
        default:
            break;
    }
}
- (void)viewDidLoad
{
    [self initData];
    [self initBuilding];
    [self initMap];
    [self initFloor];
    [self initClass];
    [self initTime];
}
- (void)initData
{
    Floors=[[NSArray alloc] initWithObjects:@"第一层",@"第二层",@"第三层",@"第四层",@"第五层",@"第六层",@"第七层",@"第八层",@"第九层",@"第十层", nil];
    myUserData=[[UserChoosedData alloc]init];
    myDatabase=[ClassDatabase new];
    myIPDate=[IPDate new];
    mychoosedBuildingID=0;
    [myUserData resetChoosedData];
}
- (void)initBuilding
{
    self.Wronglabel.hidden=true;
    Building=[[NSMutableArray alloc] initWithArray:[myDatabase getBuild]];
    int i;
    for(i=0;i<[Building count];i++)
    {
        myBuild=[Building objectAtIndex:i];
    }
    UIButton *bu;
    Button = [NSMutableArray arrayWithCapacity:5];
    for(i=0;i<[Building count];i++)
    {
        
        bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bu addTarget:self action:@selector(ChooseBuilding:) forControlEvents:UIControlEventTouchUpInside];
        [bu setBackgroundImage:[UIImage imageNamed:@"unClick"] forState:UIControlStateNormal];
        [Button addObject:bu];
        bu.tag=i+500;
        bu.frame= CGRectMake(5+106*i, 8, 98, 36);
        myBuild=[Building objectAtIndex:i];
        [bu setTitle:myBuild->buildName forState:UIControlStateNormal];
        [self.myScrollView addSubview:bu];
    }
    [myScrollView setContentSize:CGSizeMake([Building count]*106+3, myScrollView.frame.size.height)];
}
- (void)initMap
{
    self.myMapView=[[MapView alloc] initWithSuperView:self.view:(NSArray *)Building];
}
- (void)initTime
{
    TimeNow=[[NSDateFormatter alloc]init];
    [TimeNow setDateFormat:@"YYYY-MM-dd"];
    [self.DateButton setTitle:[TimeNow stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    myUserData->choosedDate=[[NSDate date] timeIntervalSince1970];
    [TimeNow setDateFormat:@"HH:mm"];
    if([[TimeNow stringFromDate:[NSDate date]] compare:@"09:35"]==-1)
    {
        [self.FromClassButton setTitle:@"第一节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第一节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=1;
        myUserData->choosedClassToID=1;
    }
    else if([[TimeNow stringFromDate:[NSDate date]] compare:@"11:25"]==-1)
    {
        [self.FromClassButton setTitle:@"第二节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第二节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=2;
        myUserData->choosedClassToID=2;
    }
    else if([[TimeNow stringFromDate:[NSDate date]] compare:@"14:35"]==-1)
    {
        [self.FromClassButton setTitle:@"第三节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第三节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=3;
        myUserData->choosedClassToID=3;
    }
    else if([[TimeNow stringFromDate:[NSDate date]] compare:@"16:25"]==-1)
    {
        [self.FromClassButton setTitle:@"第四节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第四节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=4;
        myUserData->choosedClassToID=4;
    }
    else if([[TimeNow stringFromDate:[NSDate date]] compare:@"18:15"]==-1)
    {
        [self.FromClassButton setTitle:@"第五节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第五节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=5;
        myUserData->choosedClassToID=5;
    }
    else if([[TimeNow stringFromDate:[NSDate date]] compare: @"21:25"]==-1)
    {
        [self.FromClassButton setTitle:@"第六节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第六节" forState:UIControlStateNormal];
        myUserData->choosedClassFromID=6;
        myUserData->choosedClassToID=6;
    }
    else
    {
        [self.FromClassButton setTitle:@"第一节" forState:UIControlStateNormal];
        [self.ToClassButton setTitle:@"第一节" forState:UIControlStateNormal];
        [TimeNow setDateFormat:@"YYYY-MM-dd"];
        [self.DateButton setTitle:[TimeNow stringFromDate:[[NSDate date] dateByAddingTimeInterval:3600*24]] forState:UIControlStateNormal];
        myUserData->choosedClassFromID=1;
        myUserData->choosedClassToID=1;
        myUserData->choosedDate=[[[NSDate date] dateByAddingTimeInterval:3600*24] timeIntervalSince1970];
    }
    self.myTimePickerView=[[TimePickerView alloc] initWithSuperView:self.view:myDatabase];
}
- (void)initFloor
{
    self.myChooseView_1=[[ChooseView alloc] initWithSuperView:self.view];
    self.myChooseView_2=[[ChooseView alloc] initWithSuperView:self.view];
    myChooseView_1.ListData = [[NSArray alloc]initWithArray:[self getFloor]];
    myChooseView_2.ListData = [[NSArray alloc]initWithArray:[self getFloor]];
}
- (void)initClass
{
    self.myChooseView_3=[[ChooseView alloc] initWithSuperView:self.view];
    self.myChooseView_4=[[ChooseView alloc] initWithSuperView:self.view];
    myChooseView_3.ListData = [[NSArray alloc]initWithArray:[myDatabase getTimes]];
    myChooseView_4.ListData = [[NSArray alloc]initWithArray:[myDatabase getTimes]];
}
- (void)viewDidUnload
{
    self.myTimePickerView=nil;
    self.myChooseView_1=nil;
    self.myChooseView_2=nil;
    self.myChooseView_3=nil;
    self.myChooseView_4=nil;
    self.myMapView=nil;
    self.ListData=nil;

    [self setMyTimePickerView:nil];
    [self setDateButton:nil];
    [self setMyChooseView_1:nil];
    [self setMyChooseView_2:nil];
    [self setMyChooseView_3:nil];
    [self setMyChooseView_4:nil];
    [self setMyMapView:nil];
    [self setMySearchButton:nil];
    [self setMyScrollView:nil];
    [self setMyView:nil];
    [self setMyView:nil];
    [self setWronglabel:nil];
    [self setFromClassButton:nil];
    [self setToClassButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSMutableArray *)getFloor
{
    NSMutableArray *buildfloor=[NSMutableArray arrayWithCapacity:5];
    int i,j;
    if(mychoosedBuildingID==0)
    {
        return nil;
    }
    for(i=0;i<[Building count];i++)
    {
        if(((mychoosedBuildingID>>i)&1)==1)
        {
            break;
        }
    }
    i=[myDatabase getFloor:(i+1)];
    for(j=0;j<i;j++)
    {
        [buildfloor addObject:[Floors objectAtIndex:j]];
    }
    return buildfloor;
}
- (void)resetSearchButton
{
    [mySearchButton setEnabled:YES];
}
- (BOOL)checkFloor
{
    if(mychoosedBuildingID==0)
    {
        Wronglabel.hidden=false;
        [self shake:myView];
        return false;
    }
    return true;
}
- (int)checkTime
{
    NSString *i=[[NSString alloc]init];
    i=[myIPDate getWeekName:myUserData->choosedDate];
    NSLog(@"%@",i);
    if(myUserData->choosedDate<[myDatabase getTermStart]||myUserData->choosedDate>[myDatabase getTermEnd])
    {
        return 1;
    }
    if([i isEqualToString:@"Sat"]||[i isEqualToString:@"Sun"])
    {
        return 2;
    }
    return 0;
}
- (void)shake:(UIView *)shakeView
{
    
    CGFloat t =2.0;
    CGAffineTransform translateRight =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    shakeView.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{[UIView setAnimationRepeatCount:2.0];shakeView.transform = translateRight;}completion:^(BOOL finished){if(finished){[UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{shakeView.transform =CGAffineTransformIdentity;}completion:NULL];}}];
}
- (IBAction)ClickButton:(id)sender
{
    if ([sender tag]==1)
    {
        if([self checkFloor])
        {
            ButtonSender=sender;
            myChooseView_1.delegate=self;
            [mySearchButton setEnabled:NO];
            [self.myChooseView_1 loadView:self.view];
        }
    }
    else if ([sender tag]==2)
    {
        if([self checkFloor])
        {
            ButtonSender=sender;
            myChooseView_2.delegate=self;
            [mySearchButton setEnabled:NO];
            [self.myChooseView_2 loadView:self.view];
        }
    }
    else if ([sender tag]==3)
    {
        ButtonSender=sender;
        myChooseView_3.delegate=self;
        [mySearchButton setEnabled:NO];
        [self.myChooseView_3 loadView:self.view];

    }
    else if ([sender tag]==4)
    {
        ButtonSender=sender;
        myChooseView_4.delegate=self;
        [mySearchButton setEnabled:NO];
        [self.myChooseView_4 loadView:self.view];
        
    }
    else if ([sender tag]==5)
    {
        
        ButtonSender=sender;
        myTimePickerView.delegate=self;
        [mySearchButton setEnabled:NO];
        [self.myTimePickerView loadView:self.view];
    }
    else if ([sender tag]==7)
    {
        ButtonSender=sender;
        myMapView.delegate=self;
        [mySearchButton setEnabled:NO];
        [self.myMapView loadView:self.view];
    }
}
- (long)resetBuildID:(long)ID
{
    int i;
    long result=0;
    for(i=0;i<[Building count];i++)
    {
        myBuild=[Building objectAtIndex:i];
        if(((ID>>i)&1)==1)
        {
            result=result|(1<<(myBuild->buildId-1));
        }
    }
    return result;
}
@end


