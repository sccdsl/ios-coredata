//
//  Achievement+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/14.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import "Achievement+CoreDataProperties.h"

@implementation Achievement (CoreDataProperties)

+ (NSFetchRequest<Achievement *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Achievement"];
}

@dynamic age;
@dynamic gender;
@dynamic name;
@dynamic score;
@dynamic studentID;
@dynamic subject;

@end
