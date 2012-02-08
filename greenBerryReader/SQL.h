//
//  SQL.h
//  aliAlbum
//
//  Created by zhuhaoyang on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "PublicDefine.h"

@protocol SQLDelegate;


@interface SQL : NSObject {
	id <SQLDelegate> m_SQLHandler;
	NSArray * arrDataFromSQL;
	BOOL tag;
	DatabaseManager *dbManager;
}

@property(nonatomic,retain) NSArray * arrDataFromSQL;

-(id)initWithDelegate:(id <SQLDelegate>) aDelegate;
-(void)UpdataSQL:(NSArray *)array;
-(void)sendRequestToSQL;
-(void)passDataOut;
-(void)deleteData;
@end

@protocol SQLDelegate<NSObject>
@required
-(void)queryDataCallBack:(NSArray*)arrCallBack;
@end