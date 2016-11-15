//
//  ViewController.m
//  CoreDataDemo
//
//  Created by sunlang on 2016/11/11.
//  Copyright © 2016年 sunlang. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseHandle.h"
#import "MyTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (strong, nonatomic) NSMutableArray *infos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addInfo:) name:@"addinfo" object:nil];
    
    self.listView.rowHeight = UITableViewAutomaticDimension;
    
    self.listView.estimatedRowHeight = 300;
    
    [self.listView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)infos
{
    if (!_infos) {
        
        _infos = [NSMutableArray array];
    }
    
    return _infos;
}

- (void)reloadData
{
    NSArray *array = [[DatabaseHandle shareDatabase] loadAllAchv];
    [self.infos addObjectsFromArray:array];
}


- (void)addInfo:(NSNotification *)no
{
    NSDictionary *obj = [no object];

    Achievement *achv = [[DatabaseHandle shareDatabase] addAchievement:obj];
    if (achv)
    {
        [self.infos addObject:achv];
        [self.listView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    Achievement *achv = self.infos[indexPath.row];
    cell.name.text = achv.name;
    cell.studentID.text = achv.studentID;
    cell.age.text = [NSString stringWithFormat:@"%d", achv.age];
    cell.score.text = [NSString stringWithFormat:@"%d", achv.score];
    cell.subject.text = @"挖掘机";
    
    int gender = achv.gender;
    if (gender == 2) {
        cell.gender.text = @"女";
    } else if (gender == 1) {
        cell.gender.text = @"男";
    } else {
        cell.gender.text = @"未知";
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是删除
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        Achievement *achv = self.infos[indexPath.row];
        [[DatabaseHandle shareDatabase] deleteAchvWithStudentID:achv.studentID];
        [_infos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addInfo" object:nil];
}

@end
