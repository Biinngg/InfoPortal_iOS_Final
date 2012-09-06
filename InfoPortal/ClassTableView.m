//
//  ClassTableView.m
//  InfoPortal
//
//  Created by Tcat on 12-9-5.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ClassTableView.h"

@implementation ClassTableView
@synthesize myLabel;
@synthesize myView;

- (id)initWithSuperView:(UIView *)superView:(ClassDatabase *)db:(long)time:(UIButton *)Sender
{
    self = [super init];
    NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"ClassTableView" owner:self options:nil];
    self=[array objectAtIndex:0];
    [self setFrame:CGRectMake((superView.frame.size.width-self.frame.size.width)/2,-20,self.frame.size.width,self.frame.size.height)];
    self.myView.layer.cornerRadius = 16;
    self.myView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.myView.layer.borderWidth = 8;
    self.myView.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor];
    myTime=time;
    myDatabase=db;
    mySender=Sender;
    int i=[mySender tag]-1000*(int)([mySender tag]/1000);
    [myLabel setText:[NSString stringWithFormat:@"%d教室近7天空闲情况",i]];
    myLabel.textColor=[UIColor whiteColor];
    [self drawTable];
    return self;
}

-(void)drawTable
{
    myData=[[NSArray alloc]initWithArray:[myDatabase getUsage:(int)([mySender tag]/1000) :[mySender tag]-1000*(int)([mySender tag]/1000) :myTime:7]];
    UILabel *lb;
    NSDateFormatter *myfor;
    NSDate *date;
    date=[[NSDate alloc]init];
    myfor=[[NSDateFormatter alloc]init];
    [myfor setDateFormat:@"MM-dd"];
    int i=0;
    int j=0;
    for (i=1; i<7; i++)
    {
        lb=[[UILabel alloc]initWithFrame:CGRectMake(10,60+33*i, 43, 33)];
        [lb setText:[NSString stringWithFormat:@"第%d节",i]];
        [lb setTextAlignment:UITextAlignmentCenter];
        lb.font=[UIFont systemFontOfSize:13];
        lb.backgroundColor=[UIColor clearColor];
        lb.textColor=[UIColor whiteColor];
        [self.myView addSubview:lb];
    }
    for(i=0;i<6;i++)
    {
        myUsage=[myData objectAtIndex:i];
        lb=[[UILabel alloc]initWithFrame:CGRectMake(53+i*43, 61, 43, 33)];
        lb.textColor=[UIColor whiteColor];
        date=[NSDate dateWithTimeIntervalSince1970:myUsage->timeStamp];
        [lb setText:[myfor stringFromDate:date]];
        [lb setTextAlignment:UITextAlignmentCenter];
        lb.font=[UIFont systemFontOfSize:13];
        lb.backgroundColor=[UIColor clearColor];
        [self.myView addSubview:lb];
        for(j=0;j<6;j++)
        {
            lb=[[UILabel alloc]initWithFrame:CGRectMake(53+i*43, 94+33*j, 43, 33)];
            [lb setTextAlignment:UITextAlignmentCenter];
            lb.font=[UIFont systemFontOfSize:14];
            lb.backgroundColor=[UIColor clearColor];
            lb.textColor=[UIColor whiteColor];
            if([[myUsage->usageStatus objectAtIndex:j] isEqual:@"1"])
            {
                [lb setText:@"无课"];
            }
            else
            {
                [lb setText:@"有课"];
            }
            [self.myView addSubview:lb];
        }
    }

}

-(void)close
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];//动画时间长度，单位秒，浮点数
    self.frame = CGRectMake(0, -330, self.frame.size.width, self.frame.size.height);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    [NSThread sleepForTimeInterval:0.4];
}
-(void)animationFinished
{
    [self removeFromSuperview];
    [background removeFromSuperview];
}
-(void)loadView:(UIView *)superView
{
    background=[[UIView alloc]initWithFrame:superView.frame];
    background.backgroundColor=[UIColor darkGrayColor];
    background.alpha=0.8;
    [superView addSubview:background];
    self.frame = CGRectMake(0, -300, self.frame.size.width, self.frame.size.height);
    [superView addSubview:self];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.frame = CGRectMake(0, -20, self.frame.size.width, self.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
#pragma mark-
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    gest=[touch locationInView:self.myView];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint currentPosition =[touch locationInView:self.myView];
    CGFloat deltaX=fabsf(gest.x-currentPosition.x);
    CGFloat deltaY=fabsf(gest.y-currentPosition.y);
    if (deltaY>=25&&deltaX<=deltaY-5)
    {
        [self close];
    }
}
@end
