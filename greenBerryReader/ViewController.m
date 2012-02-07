//
//  ViewController.m
//  greenBerryReader
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "icloudStore.h"
#import "myBookshelf.h"
#import "client.h"
#import "setting.h"


@implementation ViewController

@synthesize timer;
@synthesize splashImageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (0) {
        splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startLog.jpg"]];
        splashImageView.frame = CGRectMake(0, -20, 320, 480);
        
        [self.view addSubview: splashImageView];
        
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 
                                                 target: self 
                                               selector: @selector(fadeScreen) 
                                               userInfo: nil repeats: NO];
    }else {
        [self showMainView];  
    }
}

- (void) fadeScreen
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.5f];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(finishedFading)];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void) finishedFading
{
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: 0.5f];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
	[splashImageView removeFromSuperview];
    
    [self showMainView]; 
}

- (void)showMainView 
{
	NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
	
    myBookshelf *bookshelf = [[myBookshelf alloc] initWithNibName:@"myBookshelf" bundle:[NSBundle mainBundle]];
	bookshelf.view.frame = CGRectMake(0, 0, 320, 480 - 108);

	UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController: bookshelf];
	[bookshelf release];
	nav1.navigationBar.barStyle = UIBarStyleBlack;
	nav1.view.frame = CGRectMake(0, 0, 320, 480 - 20);
	[controllerArray addObject:nav1];
	[nav1 release];
	
	icloudStore *icloud = [[icloudStore alloc] initWithNibName:@"icloudStore" bundle:[NSBundle mainBundle]];
	icloud.view.frame = CGRectMake(0, 0, 320, 480 - 108);
	UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:icloud];
	nav2.navigationBar.barStyle = UIBarStyleBlack;
	[icloud release];
	[controllerArray addObject:nav2];
	[nav2 release];
    
    client *clientView = [[client alloc] initWithNibName: @"client" bundle:[NSBundle mainBundle]];
    clientView.view.frame = CGRectMake(0, 0, 320, 480 - 108);
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:clientView];
	nav3.navigationBar.barStyle = UIBarStyleBlack;
	[clientView release];
	[controllerArray addObject: nav3];
	[nav3 release];
	
	setting *settingView = [[setting alloc] initWithNibName:@"setting" bundle:[NSBundle mainBundle]];
	settingView.view.frame = CGRectMake(0, 0, 320, 480 - 108);
	UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:settingView];
	nav4.navigationBar.barStyle = UIBarStyleBlack;
	[settingView release];
	[controllerArray addObject: nav4];
	[nav4 release];
	
	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	[tabBarController setViewControllers:controllerArray];
	[tabBarController.view setFrame:CGRectMake(0, 0, 320, 480 - 20)];
	
	[self.view addSubview: tabBarController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc 
{
	[splashImageView release];
	[timer release];
    [super dealloc];
}

@end
