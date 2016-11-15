//
//  DatabaseHandle.m
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/14.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import "DatabaseHandle.h"
#import "AppDelegate.h"

@implementation DatabaseHandle

static DatabaseHandle *database;

+ (id)shareDatabase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        database = [[DatabaseHandle alloc] init];
    });
    
    return database;
}

//返回delegate
- (AppDelegate *)delegate {
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//添加成绩
- (Achievement *)addAchievement:(NSDictionary *)achv
{
    NSError *error;
    
    NSManagedObjectContext *managedContext = [self delegate].persistentContainer.viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Achievement" inManagedObjectContext:managedContext];
    Achievement *achievement = (Achievement *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedContext];
    achievement.name = achv[@"name"];
    achievement.studentID = achv[@"studentID"];
    achievement.gender = [achv[@"gender"] intValue];
    achievement.age = [achv[@"age"] intValue];
    achievement.score = [achv[@"score"] intValue];
    achievement.subject = 10086;
     
    BOOL result = [[self delegate].persistentContainer.viewContext save:&error];
    if (result) {
        return achievement;
    }
    return nil;
}

- (NSArray *)loadAllAchv
{
    //创建请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //设置需要查询的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Achievement" inManagedObjectContext:[self delegate].persistentContainer.viewContext];
    
    //设置请求实体
    [request setEntity:entity];
    
    NSError *error = nil;
    
    NSArray *infos = [[[self delegate].persistentContainer.viewContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (!error) {
        
        return infos;
    }
    
    return nil;
}

- (BOOL)deleteAchvWithStudentID:(NSString *)stdId
{
    NSPredicate *perdicate = [NSPredicate predicateWithFormat:@"studentID = %@", stdId];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Achievement" inManagedObjectContext:[self delegate].persistentContainer.viewContext];

    [request setEntity:entity];
    
    [request setPredicate:perdicate];
    
    [request setFetchLimit:1];
    
    NSError *error = nil;
    
    NSArray *infos = [[[self delegate].persistentContainer.viewContext executeFetchRequest:request error:&error] mutableCopy];
    if (infos == nil) {
        return NO;
    }
    
    for (Achievement *achv in infos) {
        [[self delegate].persistentContainer.viewContext deleteObject:achv];
        [[self delegate].persistentContainer.viewContext save:&error];
        return YES;
    }
    
    return NO;
}

- (Achievement *)queryAchvWithStudentIDL:(NSString *)stdId
{
    return nil;
}

- (BOOL)updateAchv:(Achievement *)achv
{
    return YES;
}

@end
