//
//  DatabaseManager.m
//  aliAlbum
//
//  Created by xugaoqiang on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"
#import "PublicDefine.h"

#define Database_File_Name @"aliAlbum.db"

static DatabaseManager *instance = nil;

@interface DatabaseManager(private)
- (void) createSomeTables;
@end

@implementation DatabaseManager

- (id)init
{
	self = [super init];
	if (self)
	{
		// Check database file and create the db file if it doesn't exist.
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *dbPath = [documentDirectory stringByAppendingPathComponent:Database_File_Name];
		m_db = [[FMDatabase alloc] initWithPath:dbPath];
		// Create some tables
		[self createSomeTables];
	}
	return self;
}

- (void)dealloc
{
	[m_db release];
	[super dealloc];
}

#pragma mark -
#pragma mark Class Methods
+ (DatabaseManager*) sharedDatabaseManager
{
	if (nil == instance)
	{
		instance = [[self alloc] init];
	}
	return instance;
}

#pragma mark -
#pragma mark Normal Methods
- (void) createSomeTables
{
	// Open database
//	if (![m_db open])
//	{
//		return;
//	}
	// Create tables
	NSString *sSQL = nil;
	// 1. table photo list for uploading
	sSQL = [[NSString alloc] initWithFormat:SQL_CREATE_TABLE_TEST, 
			TableNameTest, 
			kTableFormatTest];
	[self createTable:sSQL];
	SAFE_RELEASE(sSQL);
		
	// Close database
//	[m_db close];
}

#pragma mark -
#pragma mark Database Operation
- (void) createTable:(NSString*) sSQL
{
	if (![m_db open])
	{
		return;
	}
	BOOL result = [m_db executeUpdate:sSQL];
	LOGS(@"create table %@ result = %i",sSQL,result);
	[m_db close];

}

-(BOOL) deleteAllTable
{
	NSArray * arrTableName = [[NSArray alloc]initWithObjects:TableNameTest,nil];
	BOOL bRet = YES;
	// Open database
	if (![m_db open])
	{
		return NO;
	}
	NSString * tableName;
	NSUInteger i, count = [arrTableName count];
	for (i = 0; i < count; i++) {
		tableName = [arrTableName objectAtIndex:i];
		NSString *sSQL = [[NSString alloc] initWithFormat:SQL_DELETE_ALL_FROM_TABLE,
						  tableName];
		if (![m_db executeUpdate:sSQL]) {
			bRet = NO;
			LOGS(@"delete %@ fail",tableName);
		}else {
			LOGS(@"delete %@ succeed！",tableName);
		}

		SAFE_RELEASE(sSQL);
	}
	// Close database
	[m_db close];
	
	return bRet;
}

- (BOOL) queryDataIfExist:(NSString *)aaa tableName:(NSString*)tableName
{
	BOOL bRet = NO;
	// Open database
	if (![m_db open])
	{
		return bRet;
	}
	
	NSString *sSQL = [[NSString alloc] initWithFormat:SQL_QUERY_DATA_IF_EXIST, tableName, @"aaa"];
	FMResultSet *rs = [m_db executeQuery:sSQL, aaa];
	SAFE_RELEASE(sSQL);
	while ([rs next])
	{
		NSString * m_aaa = [rs stringForColumn:@"aaa"];
		if ([m_aaa isEqualToString:aaa]) 
		{
			bRet = YES;
			break;
		}
	}
	// Close database
	[m_db close];
	return bRet;	
}


- (void) insertData:(NSArray *)arrTableData
{
	BOOL bAlreadyExist = [self queryDataIfExist:[arrTableData objectAtIndex:0] tableName:TableNameTest];
	if (YES == bAlreadyExist)
	{
		LOGS(@"Metadata:%@ already exists in the table:%@", [arrTableData objectAtIndex:0], TableNameTest);
		return;
	}
	if (![m_db open])
	{
		return;
	}
	
	NSString *sSQL = [[NSString alloc] initWithFormat:SQL_INSERT_DATA_INTO_TABLE,
					  TableNameTest,
					  @"aaa,bbb,ccc,ddd,eee,fff,ggg"];
    [m_db executeUpdate: sSQL ,
	 [arrTableData objectAtIndex:0],
	 [arrTableData objectAtIndex:1],
	 [arrTableData objectAtIndex:2],
	 [arrTableData objectAtIndex:3],
	 [arrTableData objectAtIndex:4],
	 [arrTableData objectAtIndex:5],
	 [arrTableData objectAtIndex:6]];		
	
	SAFE_RELEASE(sSQL);
	// Close database
	[m_db close];
	
}

- (NSArray *) queryDataFromTable:(NSString*)tableName
{
	// Open database
	if (![m_db open])
	{
		return nil;
	}
	NSString *sSQL = [[NSString alloc] initWithFormat:SQL_QUERY_ALL_FROM_TABLE,tableName];
	FMResultSet *rs = [m_db executeQuery:sSQL];
	SAFE_RELEASE(sSQL);
	NSMutableArray *arrTableData = [[NSMutableArray alloc] init];
	while ([rs next])
	{
		NSArray *arr = [[NSArray alloc] initWithObjects:
						[rs stringForColumn:@"aaa"],
						[rs stringForColumn:@"bbb"],
						[rs stringForColumn:@"ccc"],
						[rs stringForColumn:@"ddd"],
						[rs stringForColumn:@"eee"],
						[rs stringForColumn:@"fff"],
						[rs stringForColumn:@"ggg"],nil];
//		LOGS(@"%@",[rs stringForColumn:@"aaa"]);
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"aaa"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"bbb"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"ccc"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"ddd"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"eee"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"fff"] encoding:NSUTF8StringEncoding],
//						[NSString stringWithCString:[rs UTF8StringForColumnName:@"ggg"] encoding:NSUTF8StringEncoding],nil];
//		
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"aaa"] encoding:NSUTF8StringEncoding]);		
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"bbb"] encoding:NSUTF8StringEncoding]);					
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"ccc"] encoding:NSUTF8StringEncoding]);					
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"ddd"] encoding:NSUTF8StringEncoding]);					
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"eee"] encoding:NSUTF8StringEncoding]);					
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"fff"] encoding:NSUTF8StringEncoding]);					
//		LOGS(@"%@",[NSString stringWithCString:[rs UTF8StringForColumnName:@"ggg"] encoding:NSUTF8StringEncoding]);					
//
//		LOGS(@"arr:%@",[arr objectAtIndex:0]);
		[arrTableData addObject:arr];
		[arr release];
	}
	// Close database
	[m_db close];
//	LOGS(@"queryDataFromTable:%@",[[arrTableData objectAtIndex:0] objectAtIndex:0]);
	return (NSArray *)[arrTableData retain];	
	//	return arrTableData;
}


@end
