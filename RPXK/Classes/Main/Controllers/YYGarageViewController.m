//
//  YYGarageViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYGarageViewController.h"
#import "YYGarageViewCell.h"
#import "YYBaseRequest.h"
#import "YYDeviceModel.h"
#import "YYSetMainDeviceRequest.h"
#import "YYDeleteBikeRequest.h"

@interface YYGarageViewController ()<UITableViewDelegate,UITableViewDataSource,GarageViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray<YYDeviceModel *> *models;

@end

@implementation YYGarageViewController

-(NSArray<YYDeviceModel *> *)models
{
    if (_models == nil) {
        _models = [NSArray array];
    }
    return _models;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车辆管理";
    
    [self requestMyBikes];
    // Do any additional setup after loading the view.
}

- (void) requestMyBikes
{
    YYBaseRequest *request = [[YYBaseRequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kMyBikesAPI];
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            weakSelf.models = [YYDeviceModel modelArrayWithDictArray:response];
            
            [weakSelf.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
    
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
    return self.models.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYGarageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"garage"];
    cell.model = self.models[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)YYGarageViewCell:(YYGarageViewCell *)cell didClickSetButton:(UIButton *)setButton
{
    YYSetMainDeviceRequest *request = [[YYSetMainDeviceRequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kSetMainDeviceAPI];
    request.deviceid = cell.model.deviceid;
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            [weakSelf requestMyBikes];
        }else{
            [QMUITips showWithText:message inView:weakSelf.view hideAfterDelay:2];
        }
    } error:^(NSError *error) {
        
    }];
    
}


-(void)YYGarageViewCell:(YYGarageViewCell *)cell didClickDeleteButton:(UIButton *)deleteButton
{
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
        YYDeleteBikeRequest *request = [[YYDeleteBikeRequest alloc] init];
        request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kDelBikeAPI];
        request.deviceid = cell.model.deviceid;
        request.pid = cell.model.ID;
        __weak __typeof(self)weakSelf = self;
        [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
            if (success) {
                [QMUITips showSucceed:message inView:weakSelf.view hideAfterDelay:2];
                
                [weakSelf requestMyBikes];
            }else{
               [QMUITips showWithText:message inView:self.view hideAfterDelay:2];
            }
        } error:^(NSError *error) {
            [QMUITips showWithText:@"网络不给力" inView:self.view hideAfterDelay:2];
        }];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗" preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
    
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
