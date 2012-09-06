//
//  ChooseView.h
//  InfoPortal
//
//  Created by USTB on 12-8-31.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIViewPassValueDelegate.h"

@interface ChooseView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSObject<UIViewPassValueDelegate> *delegate;
    UIView *background;
    NSArray *ListData;
    UIView *alertShowView;
}
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,retain) NSArray *ListData;
@property (nonatomic)NSObject<UIViewPassValueDelegate>* delegate;
- (IBAction)ButtonClick:(id)sender;
-(void)loadView:(UIView *)superView;
-(id)initWithSuperView:(UIView *)superView;
@end
