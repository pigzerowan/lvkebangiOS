//
//  InvitePeopleModel.h
//  greenkebang
//
//  Created by 徐丽霞 on 16/6/28.
//  Copyright © 2016年 transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol InvitePeopleDetailModel <NSObject>
@end

@interface InvitePeopleDetailModel : LKBBaseModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;


@end


@interface InvitePeopleModel : LKBBaseModel
@property (nonatomic, copy) NSArray<InvitePeopleDetailModel>* data;

@end
