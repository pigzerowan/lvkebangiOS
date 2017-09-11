//
//  ContactsDao.m
//  DataBaseContact
//
//  Created by lunarboat on 15/9/7.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "ContactsDao.h"
#import "LKBBaseModel.h"

@implementation ContactsDao

+(NSMutableArray*)queryData{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM mycontacts"];
    while ([rs next]) {
        friendDetailModel *contact = [[friendDetailModel alloc]init];
        contact.userName = [rs stringForColumn:@"contact_contactName"];
        contact.userId = [rs stringForColumn:@"contact_userId"];
//        contact.custName = [rs stringForColumn:@"contact_custName"];
        contact.avatar = [rs stringForColumn:@"contact_image"];
//        contact.userId = [rs stringForColumn:@"contact_userId"];
        //        contact.contactID = [rs stringForColumn:@"contact_id"];
//        contact.userName = [rs stringForColumn:@"contact_name"];
        //        contact.avatar = [rs stringForColumn:@"contact_avatar"];
//        contact.singleDescription = [rs stringForColumn:@"contact_singleDe
        [array addObject:contact];
    }
    [rs close];
    [db close];
    return array;
}
+(BOOL)insertData:(friendDetailModel*)contact{
    
    //    NSLog(@"hshhlallalalal====%@====lalasss",contact.contactID);
    NSLog(@"hshhlallalalal====%@====lalasss",contact.userName);
//    NSLog(@"hshhlallalalal====%@====lalasss",contact.contactName);
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    
    if ([db tableExists:@"mycontacts"]) {
        result = YES;
    }else{
        if ([db executeUpdate:@"CREATE TABLE mycontacts(contact_userId TEXT PRIMARY KEY, contact_contactName TEXT , contact_image TEXT )"]) {
            result = YES;
        }
    }
    
   if ([db executeUpdate:@"INSERT INTO mycontacts(contact_contactName,contact_userId,contact_image) VALUES (?,?,?)",contact.userName,contact.userId,contact.avatar]) {
        result = YES;
    }
    [db close];
    return result;
}
+(BOOL)deleteData:(NSString*)contactID{
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    if ([db executeUpdate:@"DELETE FROM mycontacts WHERE contact_userId = (?)",contactID]) {
        result = YES;
    }
    [db close];
    return result;
}

+(BOOL)updateData:(friendDetailModel*)contact{
    BOOL result = NO;
    FMDatabase *db = [DatebaseUtil shareDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    
    
    
    if ([db executeUpdate:@"UPDATE mycontacts SET contact_userId = (?),contact_contactName = (?),contact_image = (?)",contact.userId,contact.userName,contact.avatar]) {
        result = YES;
    }
    [db close];
    return result;
}

@end
