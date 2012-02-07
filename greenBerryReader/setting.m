//
//  setting.m
//  greenBerryReader
//
//  Created by  on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "setting.h"

@implementation setting

@synthesize m_tableview; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设    置";
	self.tabBarItem.image = [UIImage imageNamed:@"more.png"];
    self.tabBarItem.title = @"系统设置"; 
    
    UIBarButtonItem *returnInfoBtn = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStylePlain 
																	 target:self action:@selector(SendEmail:)];
	self.navigationItem.leftBarButtonItem = returnInfoBtn;
	[returnInfoBtn release];
	
	UIBarButtonItem *loginOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain 
																   target:self action:@selector(LoginOut:)];
	self.navigationItem.rightBarButtonItem = loginOutBtn;
	[loginOutBtn release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [m_tableview release];
    [super dealloc]; 
}

- (void)SendEmail:(id)sender
{
	NSLog(@"--------sendEmail---------");
	
}

- (void)LoginOut:(id)sender
{
	NSLog(@"--------loginOut-----------");
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (tableView == self.m_tableview) 
	{
		if (section == 0) {
			return [NSString stringWithFormat:@"账户设置"];
		}
		else if (section == 1) {
			return [NSString stringWithFormat:@"版本信息"];
		}
		else {
			return [NSString stringWithFormat:@"系统设置"];
		}
	}
	else {
		return nil;
	}
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	
	if (section == 1) {
		return 2;
	}
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	NSInteger section = [indexPath section];
	
	if (section == 0) {
		cell.textLabel.text = @"修改密码";
	}
    else if (section == 1) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"使用指南";
		}
		else {
			cell.textLabel.text = @"版本检测";
		}
	}
	else {
		cell.textLabel.text = @"主题更换";
	}
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //	if ([indexPath section] == 0 && []) {
    //		<#statements#>
    //	}
}

@end
