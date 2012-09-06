//
//  ClassResultViewController.m
//  InfoPortal
//
//  Created by Tcat on 12-9-4.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassResultViewController.h"

@interface ClassResultViewController ()

@end

@implementation ClassResultViewController
@synthesize myView;
@synthesize MainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil:(UserChoosedData *)data:(ClassDatabase *)db
{
    myUserData=data;
    myDatabase=db;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    myResultData=[[NSMutableArray alloc]initWithArray:[myDatabase getResult:myUserData->choosedBuildingID :myUserData->choosedFloorFromID :myUserData->choosedFloorToID :myUserData->choosedClassFromID :myUserData->choosedClassToID :myUserData->choosedDate]];
    barButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = barButtonItem;
    myDatabase=[[ClassDatabase alloc]init];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    int i,j,y;
    i=0;
    j=0;
    y=0;
    myResult=[[StructResult alloc]init];
    UILabel *myText;
    UIButton *myButton;
    
    
    for(i=0;i<[myResultData count];i++)
    {
        myResult=[myResultData objectAtIndex:i];
        myText=[[UILabel alloc]initWithFrame:CGRectMake(0, y, 320, 25)];
        y+=35;
        [myText setBackgroundColor:[UIColor lightGrayColor]];
        myText.font=[UIFont systemFontOfSize:14];
        [myText setText:[myDatabase getBuildName:myResult->buildId]];
        [self.myView addSubview:myText];
        for(j=0;j<[myResult->roomName count];j++)
        {
            myButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [myButton setFrame:CGRectMake(12+(j%4)*77, y+44*(int)(j/4), 65, 34)];
            [myButton setTitle:[myResult->roomName objectAtIndex:j]  forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [myButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [myButton setTag:(myResult->buildId)*1000+[[myResult->roomName objectAtIndex:j] integerValue]];
            [self.myView addSubview:myButton];
        }
        if(j!=0)
            y+=44*(1+(int)((j-1)/4));
    }
    [myView setContentSize:CGSizeMake(myView.frame.size.width,y)];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)ClickButton:(id)sender
{
    myClassTableView=[[ClassTableView alloc] initWithSuperView:self.myView :myDatabase :myUserData->choosedDate:sender];
    [myClassTableView loadView:self.MainView];
}
- (void)viewDidUnload
{
    [self setMyView:nil];
    [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
