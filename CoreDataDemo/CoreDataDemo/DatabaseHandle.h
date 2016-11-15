//
//  DatabaseHandle.h
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/14.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Achievement+CoreDataProperties.h"

@interface DatabaseHandle : NSObject

+ (id)shareDatabase;

- (Achievement *)addAchievement:(NSDictionary *)achv;

- (NSArray *)loadAllAchv;

- (BOOL)deleteAchvWithStudentID:(NSString *)stdId;

- (Achievement *)queryAchvWithStudentIDL:(NSString *)stdId;

- (BOOL)updateAchv:(Achievement *)achv;

@end
