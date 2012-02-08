//
//  DatabaseManager.h
//  aliAlbum
//
//  Created by xugaoqiang on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@interface DatabaseManager : NSObject 
{
	FMDatabase *m_db;
}

+ (DatabaseManager*) sharedDatabaseManager;

- (void) createTable:(NSString*) sSQL;
- (BOOL) deleteAllTable;
- (BOOL) queryDataIfExist:(NSString *)aaa tableName:(NSString*)tableName;
- (void) insertData:(NSArray *)arrTableData;
- (NSArray *) queryDataFromTable:(NSString*)tableName;


@end