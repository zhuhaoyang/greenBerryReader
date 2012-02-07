//
//  ViewController.h
//  greenBerryReader
//
//  Created by  on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
	NSTimer *timer;
	UIImageView *splashImageView;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIImageView *splashImageView;

- (void)fadeScreen;
- (void)finishedFading;
- (void)showMainView;

@end
