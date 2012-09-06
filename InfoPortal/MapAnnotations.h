//
//  MapAnnotations.h
//  InfoPortal
//
//  Created by USTB on 12-9-3.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotations : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSString *subtitle;
@property(nonatomic,retain)NSString *title;
@end
