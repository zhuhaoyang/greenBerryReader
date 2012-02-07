//
//  setting.h
//  greenBerryReader
//
//  Created by  on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setting : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
	IBOutlet UITableView *m_tableview;
}

@property (nonatomic, retain) UITableView *m_tableview;

@end
