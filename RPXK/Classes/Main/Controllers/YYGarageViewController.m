//
//  YYGarageViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYGarageViewController.h"
#import "YYGarageViewCell.h"

@interface YYGarageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YYGarageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车辆管理";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYGarageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"garage"];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return NO;
}

@end
