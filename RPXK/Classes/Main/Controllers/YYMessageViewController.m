//
//  YYMessageViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/27.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYMessageViewController.h"
#import "YYMessageViewCell.h"

@interface YYMessageViewController ()


@end

#define cellIdentifier @"message"

@implementation YYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息";
    // Do any additional setup after loading the view.
}

-(void)initTableView
{
    [super initTableView];
    
    //[self.tableView registerClass:[YYMessageViewCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YYMessageViewCell class]) bundle:nil
                                 ] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView qmui_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {

    }];
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

- (UITableViewCell *)qmui_tableView:(UITableView *)tableView cellWithIdentifier:(NSString *)identifier {
    YYMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
