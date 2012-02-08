//
//  PublicDefine.h
//  excel
//
//  Created by zhuhaoyang on 11-11-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// Log Print  on->1  off->0
#define LOG_STATE 1

#if LOG_STATE
#define LOGS(msg1, ...) NSLog(msg1, ##__VA_ARGS__)
#else
#define LOGS(msg1, ...)
#endif

// Safe Release
#define SAFE_RELEASE(object)\
{\
if (nil != object)\
{\
[object release];\
object = nil;\
}\
}





#define TableNameTest @"Test_Table"

#define kTableFormatTest @"aaa text, bbb text, ccc text, ddd text, eee text, fff text, ggg text"

#define SQL_CREATE_TABLE_TEST @"CREATE TABLE %@ (%@)"// Table Name, Table Format
#define SQL_DELETE_ALL_FROM_TABLE @"DELETE FROM %@"// Table Name
#define SQL_QUERY_DATA_IF_EXIST @"SELECT * FROM %@ WHERE %@ = ?"// Table Name, attribute name
#define SQL_INSERT_DATA_INTO_TABLE @"INSERT INTO %@ (%@) VALUES (?,?,?,?,?,?,?)"// Table Name, attribute name
#define SQL_QUERY_ALL_FROM_TABLE @"SELECT * FROM %@"// Table Name
