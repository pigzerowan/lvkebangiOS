//
//  ContactsDao.h
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatebaseUtil.h"
//#import "Contact.h"
#import "FriendModel.h"

@interface ContactsDao : NSObject

+(BOOL)createTable;
+(NSMutableArray*)queryData;
//+(BOOL)deleteData:(int)contactID;
+(BOOL)deleteData:(NSString*)contactID;
+(BOOL)insertData:(friendDetailModel*)contact;
+(BOOL)updateData:(friendDetailModel*)contact;

@end
