//
//  LibraryViewController.h
//  InfoPortal
//
//  Created by Tcat on 12-9-6.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LibraryViewController : UIViewController
{
    UIAlertView *myAlertView;
    CGPoint gest;
}
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
- (IBAction)Scan:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property CGPoint gest;

- (IBAction)backgroundTap:(id)sender;
@end
