//
//  MapView.h
//  InfoPortal
//
//  Created by USTB on 12-9-2.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIViewPassValueDelegate.h"
#import "MapAnnotations.h"
#import "libInfoPortal/ClassDatabase.h"
@interface MapView : UIView<MKMapViewDelegate,CLLocationManagerDelegate>
{
    NSObject<UIViewPassValueDelegate> *delegate;
    UIView *background;
    NSArray *ListData;
    StructBuild *myBuild;
    UIView *alertShowView;
    MKMapView *myMap;
    CLLocationManager *myLocationManager;
    CLLocationCoordinate2D loc;
}
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (nonatomic,retain) NSArray *ListData;
@property (nonatomic)NSObject<UIViewPassValueDelegate>* delegate;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic,retain)CLLocationManager *myLocationManager;
- (IBAction)ButtonClick:(id)sender;
-(void)loadView:(UIView *)superView;
-(id)initWithSuperView:(UIView *)superView:(NSArray *)Building;
-(void)setCurrentLocation:(CLLocation *)location;

@end
