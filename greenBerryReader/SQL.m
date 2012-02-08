//
//  SQL.m
//  aliAlbum
//
//  Created by zhuhaoyang on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SQL.h"


@implementation SQL
@synthesize arrDataFromSQL;

-(id)initWithDelegate:(id <SQLDelegate>) aDelegate
{
	self = [super init];
	if (self) {
		tag = NO;
		m_SQLHandler = aDelegate;
	}
	return self;
}

-(void)dealloc
{
	[arrDataFromSQL release];
	[super dealloc];
}

-(void)sendRequestToSQL    //解析关键字,选择数据库表
{
	dbManager = [DatabaseManager sharedDatabaseManager];

	self.arrDataFromSQL = [dbManager queryDataFromTable:TableNameTest];	//从本地数据库获取相册列表资料
//	LOGS(@"sendRequest:%@",[arrDataFromSQL objectAtIndex:0]);
	[self passDataOut];
}


-(void)deleteData
{
	dbManager = [DatabaseManager sharedDatabaseManager];
	[dbManager deleteAllTable];
}


#pragma mark -
#pragma mark UpdataSQL

-(void)UpdataSQL:(NSArray *)array
{
	dbManager = [DatabaseManager sharedDatabaseManager];
	NSUInteger i, count = [array count];
	for (i = 0; i < count; i++) {
		NSArray *arrData = [array objectAtIndex:i];
		[dbManager insertData:arrData];
	}
}



#pragma mark -
#pragma mark Pass Data To Service

-(void)passDataOut		//返还给调用者数据库内数据
{
	
	if (nil != m_SQLHandler
		&& [m_SQLHandler respondsToSelector:@selector(queryDataCallBack:)])
	{
		[m_SQLHandler queryDataCallBack:arrDataFromSQL];
	}

}


@end
