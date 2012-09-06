//
//  TimePickerView.m
//  InfoPortal
//
//  Created by USTB on 12-8-29.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView
@synthesize myLabel;
@synthesize myView;
@synthesize myDatePicker;
@synthesize delegate;


-(id)initWithSuperView:(UIView *)superView:(ClassDatabase *)db
{  
    self = [super init];
    NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"TimePickerView" owner:self options:nil];
    self=[array objectAtIndex:0];
    [self setFrame:CGRectMake((superView.frame.size.width-self.frame.size.width)/2,20,self.frame.size.width,self.frame.size.height)];
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.myView.layer.borderWidth = 8;
    self.myView.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor];
    myDatePicker.minimumDate=[NSDate dateWithTimeIntervalSince1970:[db getTermStart]];
    myDatePicker.maximumDate=[NSDate dateWithTimeIntervalSince1970:[db getTermEnd]+3600*24];
    myLabel.textColor=[UIColor whiteColor];
    [self dateChanged:myDatePicker];
    return self;
}

-(void)close
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];//动画时间长度，单位秒，浮点数
    self.frame = CGRectMake(0, 400, self.frame.size.width, self.frame.size.height);
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

- (IBAction)ButtonClick:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [delegate getdate:myDatePicker.date];
            break;
            
        default:
            break;
    }
    [self close];
}


-(void)loadView:(UIView *)superView
{
    background=[[UIView alloc]initWithFrame:superView.frame];
    background.backgroundColor=[UIColor darkGrayColor];
    background.alpha=0.8;
    [superView addSubview:background];
    self.frame = CGRectMake(0, 400, self.frame.size.width, self.frame.size.height);
    [superView addSubview:self];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    self.frame = CGRectMake(0, 25, self.frame.size.width, self.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)dateChanged:(id)sender
{
    NSString *week=[[NSString alloc]init];
    NSString *date=[[[NSString alloc]initWithFormat:@"%@",[[myDatePicker date] dateByAddingTimeInterval:3600*24]] substringToIndex:10];
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [form setDateFormat:@"EEEE"];
    week=[form stringFromDate:[myDatePicker date]];
    NSString *all=[NSString stringWithFormat:@"%@ %@",date,week];
    [myLabel setText:all];
}
@end
