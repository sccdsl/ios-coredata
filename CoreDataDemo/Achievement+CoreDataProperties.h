//
//  Achievement+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/14.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import "Achievement+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Achievement (CoreDataProperties)

+ (NSFetchRequest<Achievement *> *)fetchRequest;

@property (nonatomic) int32_t age;
@property (nonatomic) int32_t gender;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t score;
@property (nullable, nonatomic, copy) NSString *studentID;
@property (nonatomic) int32_t subject;

@end

NS_ASSUME_NONNULL_END
