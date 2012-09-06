//
//  TimePickerView.h
//  InfoPortal
//
//  Created by USTB on 12-8-29.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIViewPassValueDelegate.h"
#import "libInfoPortal/ClassDatabase.h"
@interface TimePickerView : UIView
{
    NSObject<UIViewPassValueDelegate> *delegate;
    UIView *alertShowView;
    UIView *background;
}
- (IBAction)dateChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIDatePicker *myDatePicker;
@property (nonatomic)NSObject<UIViewPassValueDelegate>* delegate;
- (IBAction)ButtonClick:(id)sender;
-(void)loadView:(UIView *)superView;
-(id)initWithSuperView:(UIView *)superView:(ClassDatabase *)db;
@end
