//
//  ChooseView.m
//  InfoPortal
//
//  Created by USTB on 12-8-31.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView
@synthesize myView;
@synthesize myTableView,ListData,delegate;

- (id)initWithSuperView:(UIView *)superView
{
    self = [super init];
    NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"ChooseView" owner:self options:nil];
    self=[array objectAtIndex:0];

    [self setFrame:CGRectMake((superView.frame.size.width-self.frame.size.width)/2,20,self.frame.size.width,self.frame.size.height)];
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.myView.layer.borderWidth = 8;
    self.myView.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor];
    return self;
}

-(void)close
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Return back to 100%
	[UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.00f];
	self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	[UIView commitAnimations];
    // Bounce to 1% of the normal size
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.15f];
	self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
	[UIView commitAnimations];
    [NSThread sleepForTimeInterval:0.2];
    [delegate resetSearchButton];
    [self setDelegate:nil];
    self.delegate=nil;
}
-(void)animationFinished
{
    [self removeFromSuperview];
    [background removeFromSuperview];
}
- (IBAction)ButtonClick:(id)sender {
    [self close];
}

-(void)loadView:(UIView *)superView
{
    background=[[UIView alloc]initWithFrame:superView.frame];
    background.backgroundColor=[UIColor darkGrayColor];
    background.alpha=0.8;
    [superView addSubview:background];
    alertShowView=[[UIView alloc]initWithFrame:superView.frame];
	alertShowView.backgroundColor=[UIColor clearColor];
	[superView addSubview:alertShowView];
	// Bounce to 1% of the normal size
	[UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.0f];
	self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
	[UIView commitAnimations];
	
	// Return back to 100%
	[UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.15f];
	self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
	[UIView commitAnimations];
	
	[superView addSubview:self];
    [alertShowView removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark -
#pragma mark Table View Data Souce Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ListData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.textAlignment=UITextAlignmentCenter;
    cell.textLabel.text = [self.ListData objectAtIndex:row];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate getnumber:[self.ListData objectAtIndex:[indexPath row]]:[indexPath row]+1];
    [self close];
}

@end
