//
//  AddViewController.m
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/14.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import "AddViewController.h"
#import "Achievement+CoreDataProperties.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *sudentID;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addaAgain:(id)sender {
    
    if (self.sudentID.text.length > 0) {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        infos[@"studentID"] = self.sudentID.text;
        infos[@"name"] = self.name.text;
        infos[@"age"] = self.age.text;
        if ([self.gender.text isEqualToString:@"男"])
        {
            infos[@"gender"] = @"1";
        }
        else if ([self.gender.text isEqualToString:@"女"]){
            infos[@"gender"] = @"2";
        }
        else
        {
            infos[@"gender"] = @"0";
        }
        
        infos[@"score"] = self.score.text;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addinfo" object:infos];
        
        self.sudentID.text = @"";
        self.name.text = @"";
        self.age.text = @"";
        self.gender.text = @"";
        self.score.text = @"";
        
    }
    else
    {
        NSLog(@"请填入学号");
    }
    
}
- (IBAction)submit:(id)sender {

    if (self.sudentID.text.length > 0) {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        infos[@"studentID"] = self.sudentID.text;
        infos[@"name"] = self.name.text;
        infos[@"age"] = self.age.text;
        if ([self.gender.text isEqualToString:@"男"])
        {
            infos[@"gender"] = @"1";
        }
        else if ([self.gender.text isEqualToString:@"女"]){
            infos[@"gender"] = @"2";
        }
        else
        {
            infos[@"gender"] = @"0";
        }
        
        infos[@"score"] = self.score.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addinfo" object:infos];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        NSLog(@"请填入学号");
    }
}

@end
