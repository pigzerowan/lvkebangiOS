//
//  LKBBaseFactory.m
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//

#import "LKBBaseFactory.h"
#import "FansModel.h"
#import "FindPeopleModel.h"
#import "ToPicModel.h"
#import "DynamicModel.h"
#import "InsightModel.h"
#import "FriendModel.h"
#import "GroupModel.h"
#import "UserCenterModel.h"
#import "ReplyModel.h"
#import "AreaModel.h"
#import "InsightDetailModel.h"
#import "DirectModel.h"
#import "BannerModel.h"
#import "RecFriendModel.h"
#import "LKBLoginModel.h"
#import "NewTimeDynamicModel.h"
#import "NewFindModel.h"
#import "ColumnModel.h"
#import "ColumnInfoMation.h"
#import "ColumnListModel.h"
#import "FindSearchModel.h"
#import "QuestionModel.h"
#import "UserInforModel.h"
#import "GroupDetaillModel.h"
#import "UserInforDynamicModel.h"
#import "ColumnAttentionModel.h"
#import "AttentionContentsModel.h"
#import "CollectionModel.h"
#import "GetCommentModel.h"
#import "GetNoticeModel.h"
#import "InviteAnswerModel.h"
#import "InvitePeopleModel.h"
#import "HoeListModel.h"
#import "StarSchoolModel.h"
#import "ActivityListModel.h"
#import "ActivityModel.h"
#import "YanzhengModel.h"
#import "CircleInfoModel.h"
#import "NewUserCenterModel.h"
#import "FindFeaturesModel.h"
#import "SystemInformsModel.h"
@implementation LKBBaseFactory
+ (LKBBaseModel *)modelWithURL:(NSString *)url responseJson:(NSDictionary *)jsonDict
{
        if ([url isEqualToString:LKB_Signup_Url] ||
            [url isEqualToString:LKB_Login_Url] ||
            [url isEqualToString:LKB_Update_Url]||
            [url isEqualToString:LKB_Social_Login_Url]||[url isEqualToString:LKB_Social_Regist_Url]||[url isEqualToString:LKB_Browsing_Login_Url]||[url isEqualToString:LKB_Update_Url]
            
            
            ) {
            return [[LKBLoginModel alloc] initWithJSONDict:jsonDict];
        }

//    if ([url isEqualToString:LKB_Attention_Friend_Url] ) {
//        return [[LKBLoginModel alloc] initWithJSONDict:jsonDict];
//    }
    

    
    if ([url isEqualToString:LKB_ALL_DYNAMIC]||[url isEqualToString:LKB_ALL_DYNAMIC_Insight]||[url isEqualToString:LKB_ALL_DYNAMIC_Question]||[url isEqualToString:LKB_ALL_DYNAMIC_Topic]||[url isEqualToString:LKB_ALL_allDynamics]||[url isEqualToString:LKB_Circle_Topic_Url]) {
        return [[NewTimeDynamicModel alloc] initWithJSONDict:jsonDict];
    }

    if ([url isEqualToString:LKB_ALL_FIND]) {
        return [[NewFindModel alloc] initWithJSONDict:jsonDict];
    }
    if ([url isEqualToString:LKB_Insight_features_Url]) {
        return [[ColumnModel alloc] initWithJSONDict:jsonDict];
    }
    
    if ([url isEqualToString:LKB_ColumnInfo_Url]) {
        return [[ColumnInfoMation alloc] initWithJSONDict:jsonDict];
    }
    
    if ([url isEqualToString:LKB_ColumnInfo_List_Url]) {
        return [[ColumnListModel alloc] initWithJSONDict:jsonDict];
    }
    
    if ([url isEqualToString:LKB_ColumnInfo_Attention_Url]) {
        return [[ColumnAttentionModel alloc] initWithJSONDict:jsonDict];
    }

    
    if ([url isEqualToString:LKB_Attention_Url]) {
        return [[FansModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_Attention_Fans_Url]) {
        return [[FansModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_FIND_PEOPLE_URL]) {
        return [[FindPeopleModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_TOPIC_ATS]) {
        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_QUESTION_DYNAMIC]) {
        return [[DynamicModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_INSIGHT_DYNAMIC]) {
        return [[InsightModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Attention_All_Url]) {
        return [[FriendModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_His_Topic_Url]) {
        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_His_Group_Url]) {
        return [[GroupModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_His_Insight_Url]) {
        return [[InsightModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_User_Center_Url]) {
        return [[UserCenterModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_FIND_Group_List_Url]) {
        return [[GroupModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_FIND_Topic_List_Url]) {
        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_FIND_Insight_List_Url]) {
        return [[InsightModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_FIND_Question_List_Url]) {
        return [[DynamicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Reply_Detail_Url]) {
        return [[ReplyModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Insight_Detail_Url]) {
        return [[InsightDetailModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Question_reply_List_Url]) {
        return [[ReplyModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_Users_Url]) {
        return [[FindPeopleModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_Groupbyid_Url]) {
        return [[GroupDetailModel alloc] initWithJSONDict:jsonDict];
    }
    
//    else if ([url isEqualToString:LKB_Group_Topic_Url]) {
//        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
//    }
    
    
    else if ([url isEqualToString:LKB_Group_QA_Url]) {
        return [[DynamicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_His_Question_Url]) {
        return [[DynamicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Search_People_Url]) {
        return [[FriendModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Search_Group_Url]) {
        return [[GroupModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Center_Arealist_Url]) {
        return [[AreaModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Center_Industrylist_Url]) {
        return [[DirectModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Insight_Replies_Url]) {
        return [[ReplyModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_ALL_FIND_COVER]) {
        return [[BannerModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Question_Detail_Url]) {
        return [[DynamicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Topic_Detail_Url]) {
        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Recommend_Friend_Url]) {
        return [[RecFriendModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Find_Search_Url]) {
        return [[FindSearchModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_List_Url]) {
        return [[GroupModel alloc] initWithJSONDict:jsonDict];
        
    }else if ([url isEqualToString:LKB_MyGroup_List_Url]||[url isEqualToString:LKB_ALLGroup_List_Url]) {
        return [[GroupModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Topic_Url]) {
        return [[ToPicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Question_Url]) {
        return [[QuestionModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_User_Infor_Url]) {
        return [[UserInforModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_Detaill_Url])   {
        return [[GroupDetaillModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_UserInfor_dynamic_Url]) {
        return [[UserInforDynamicModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Attention_All_Fans_Url]) {
        return [[FansModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Attention_Users_Url]) {
        return [[FansModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Attention_Users_Url]) {
        return [[FriendModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_ALLUsers_Url]) {
        return [[FansModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Group_UsersInfor_Url]||[url isEqualToString:LKB_Group_ALLUsers_Url]) {
        return [[FindPeopleModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Attention_Contents_Url]
              ||[url isEqualToString:LKB_All_Artic_Contents_Url]) {
        return [[AttentionContentsModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_ColumnInfo_Collection_Url]) {
        return [[CollectionModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Get_Comment]) {
        return [[GetCommentModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Dynamic_Notice]) {
        return [[GetNoticeModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Notice_Question]) {
        return [[InviteAnswerModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Invite_User]) {
        return [[InvitePeopleModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_Discover_Hoe_List_Url]) {
        return [[HoeListModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_Star_School_Url]) {
        return [[StarSchoolModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Discover_Activity_List_Url]) {
        return [[ActivityListModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Activity_Url]) {
        return [[ActivityModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_jiaoyiValidate_Url]) {
        return [[YanzhengModel alloc] initWithJSONDict:jsonDict];
    }
    else if ([url isEqualToString:LKB_Circle_Info_Url]) {
        return [[CircleInfoModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Usercenterpersonal_Url]) {
        return [[NewUserCenterModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_Find_Features_Url]) {
        return [[FindFeaturesModel alloc] initWithJSONDict:jsonDict];
    }else if ([url isEqualToString:LKB_System_Informs]) {
        return [[SystemInformsModel alloc] initWithJSONDict:jsonDict];
    }





    
    return [[LKBBaseModel alloc] initWithJSONDict:jsonDict];
    
}
@end
