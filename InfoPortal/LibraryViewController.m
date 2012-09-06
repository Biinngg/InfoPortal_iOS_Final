//
//  LibraryViewController.m
//  InfoPortal
//
//  Created by Tcat on 12-9-6.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import "LibraryViewController.h"

@interface LibraryViewController ()

@end

@implementation LibraryViewController
@synthesize myView;
@synthesize mySearchBar;
@synthesize gest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UISwipeGestureRecognizer *swipeRecognizer =         [[UISwipeGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(swipeDetected:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    mySearchBar.placeholder=@"名称或ISBN码";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setMySearchBar:nil];
    [self setMyView:nil];
    [self setMyView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)error
{
    myAlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该功能尚未完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [myAlertView show];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)Scan:(id)sender
{
    [self.tabBarController setSelectedIndex:1];
    [self error];
}

- (IBAction)backgroundTap:(id)sender {
    [mySearchBar resignFirstResponder];
    
}
- (IBAction)swipeDetected:(UIGestureRecognizer *)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    
    UITabBarController *tb = [sb instantiateViewControllerWithIdentifier:@"mainTabBar"];
    
    
    [tb setSelectedIndex:1];
    NSLog(@"sdfsdf");
}
#pragma UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    [self error];
    [mySearchBar resignFirstResponder];

}


@end
