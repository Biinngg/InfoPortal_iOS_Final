//
//  MapView.m
//  InfoPortal
//
//  Created by USTB on 12-9-2.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "MapView.h"

@implementation MapView
@synthesize myView,ListData,delegate,myMapView,myLocationManager;

- (id)initWithSuperView:(UIView *)superView:(NSArray *)Building
{
    self = [super init];
    NSArray *array =[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil];
    self=[array objectAtIndex:0];
    
    [self setFrame:CGRectMake((superView.frame.size.width-self.frame.size.width)/2,10,self.frame.size.width,self.frame.size.height)];
    self.myView.layer.cornerRadius = 8;
    self.myView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.myView.layer.borderWidth = 8;
    self.myView.layer.borderColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor];
    self.myMapView.delegate=self;
    self.myMapView.showsUserLocation=YES;
    myLocationManager.delegate=self;
    myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
    myLocationManager.distanceFilter=100;
    ListData=Building;
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
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
    [self.myLocationManager stopUpdatingLocation];
    [self setDelegate:nil];
    [self setDelegate:nil];
    [self setMyMapView:nil];
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
    [self.myLocationManager startUpdatingLocation];
    [self initMap];
    
}
-(void)initMap
{
    int i;
    NSArray *number;
    loc.latitude=39.991227;
    loc.longitude=116.355879;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.003;
    span.longitudeDelta=0.003;
    region.span=span;
    region.center=loc;
    myMapView.mapType=MKMapTypeStandard;
    [myMapView setRegion:region animated:YES];
    [myMapView regionThatFits:region];
    for(i=0;i<[ListData count];i++)
    {
        myBuild=[ListData objectAtIndex:i];
        number=[myBuild->location componentsSeparatedByString:@","];
        NSLog(@"%@",[number objectAtIndex:1]);
        [self initMapKit:[[number objectAtIndex:0] doubleValue]:[[number objectAtIndex:1] doubleValue]:myBuild->buildName];
    }
}
-(void)initMapKit:(double)x:(double)y:(NSString *)title
{
    loc.latitude=x;
    loc.longitude=y;
    MapAnnotations *myMapAnnotations;
    myMapAnnotations=[[MapAnnotations alloc]initWithCoordinate:loc];
    myMapAnnotations.title=title;
    [myMapView addAnnotation:myMapAnnotations];
    myMapAnnotations=nil;
}

#pragma mark -
#pragma mark Core Location Delegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self initMap];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
-(void)setCurrentLocation:(CLLocation *)location
{
    MKCoordinateRegion region;
    region.center=location.coordinate;
    region.span.longitudeDelta=0.15f;
    region.span.latitudeDelta=0.15f;
    [myMapView setRegion:region animated:YES];
}
@end
