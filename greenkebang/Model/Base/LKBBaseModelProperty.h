//
//  LKBBaseModelProperty.h
//  greenkebang
//
//  Created by 郑渊文 on 8/27/15.
//  Copyright (c) 2015 transfar. All rights reserved.
//
typedef NS_ENUM(NSUInteger, YTFetchModelPropertyValueType) {
    YTClassPropertyValueTypeNone = 0,
    YTClassPropertyTypeChar,
    YTClassPropertyTypeInt,
    YTClassPropertyTypeShort,
    YTClassPropertyTypeLong,
    YTClassPropertyTypeLongLong,
    YTClassPropertyTypeUnsignedChar,
    YTClassPropertyTypeUnsignedInt,
    YTClassPropertyTypeUnsignedShort,
    YTClassPropertyTypeUnsignedLong,
    YTClassPropertyTypeUnsignedLongLong,
    YTClassPropertyTypeFloat,
    YTClassPropertyTypeDouble,
    YTClassPropertyTypeBool,
    YTClassPropertyTypeVoid,
    YTClassPropertyTypeCharString,
    YTClassPropertyTypeObject,
    YTClassPropertyTypeClassObject,
    YTClassPropertyTypeSelector,
    YTClassPropertyTypeArray,
    YTClassPropertyTypeStruct,
    YTClassPropertyTypeUnion,
    YTClassPropertyTypeBitField,
    YTClassPropertyTypePointer,
    YTClassPropertyTypeUnknow
};


#import <Foundation/Foundation.h>

@interface LKBBaseModelProperty : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL isReadonly;
@property(nonatomic,copy) NSString *errorCode;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, strong) NSArray *objectProtocols;
@property (nonatomic, assign) YTFetchModelPropertyValueType valueType;

- (id)initWithName:(NSString *)name typeString:(NSString *)typeString;
@end
