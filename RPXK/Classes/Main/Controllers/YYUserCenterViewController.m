//
//  YYUserCenterViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/27.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYUserCenterViewController.h"
#import "YYFeedBackController.h"
#import "YYUserManager.h"
#import "NSNotificationCenter+Addition.h"
#import "YYLoginViewController.h"
#import "YYFileCacheManager.h"
#import <QMUIKit/QMUIKit.h>
#import <MXParallaxHeader/MXParallaxHeader.h>

@interface YYUserCenterViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
//手机号码
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
//头像
@property (weak, nonatomic) IBOutlet UIButton *avatarImageView;

@end

@implementation YYUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [NSNotificationCenter addObserver:self action:@selector(logoutSuccessAction:) name:kLogoutSuccessNotification];
    QMUILog(@"%@",[YYFileCacheManager readUserDataForKey:kUserInfoKey]);
    NSDictionary *dict = [YYFileCacheManager readUserDataForKey:kUserInfoKey];
    self.mobileLabel.text = [NSString stringWithFormat:@"%@",dict[@"tel"]];
    // Do any additional setup after loading the view.
}

-(void) logoutSuccessAction:(NSNotification *)noti
{
    YYLoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:loginViewController animated:NO completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTableView
{
    [super initTableView];
    
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:@[@[({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 2;
        d.text = @"车辆管理";
        d.image = [UIImage imageNamed:@"车辆管理"];
        d.height = 60;
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d;
    }),({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 3;
        d.height = 60;
        d.text = @"紧急呼叫";
        d.image = [UIImage imageNamed:@"紧急呼叫"];
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d;
    }),({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 4;
        d.height = 60;
        d.text = @"系统消息";
        d.image = [UIImage imageNamed:@"系统消息"];
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d;
    }),({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 5;
        d.height = 60;
        d.text = @"关于我们";
        d.image = [UIImage imageNamed:@"关于我们"];
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d;
    }),({
        QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
        d.identifier = 6;
        d.height = 60;
        d.text = @"意见反馈";
        d.image = [UIImage imageNamed:@"意见反馈"];
        d.didSelectTarget = self;
        d.didSelectAction = @selector(handleDisclosureIndicatorCellEvent:);
        d.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
        d;
    })]]];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0 );
    self.tableView.parallaxHeader.height = 208;
    self.tableView.parallaxHeader.mode = MXParallaxHeaderModeTopFill;
    self.tableView.parallaxHeader.minimumHeight = 208;
    self.tableView.parallaxHeader.delegate = self;
    self.tableView.parallaxHeader.view = self.headerView;
    self.tableView.qmui_staticCellDataSource = dataSource;
}

-(void) handleDisclosureIndicatorCellEvent:(QMUIStaticTableViewCellData *)data
{
    if (data.identifier == 4) {
        [self performSegueWithIdentifier:@"systemMsg" sender:self];
    }else if (data.identifier == 3){
        [self performSegueWithIdentifier:@"eCall" sender:self];
    }else if (data.identifier == 6){
        YYFeedBackController *feedBackController = [[YYFeedBackController alloc] init];
        [self.navigationController pushViewController:feedBackController animated:YES];
    }else if (data.identifier == 2){
        [self performSegueWithIdentifier:@"garage" sender:self];
    }else if (data.identifier == 5){
        [self performSegueWithIdentifier:@"about" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return YES;
}

- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logoutButtonClick:(id)sender {
    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {
    }];
    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertAction *action) {
        [YYUserManager logout];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录吗" preferredStyle:QMUIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController showWithAnimated:YES];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [tableView.qmui_staticCellDataSource cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 因为需要自定义 cell 的内容，所以才需要重写 tableView:didSelectRowAtIndexPath: 方法。
    // 当重写这个方法时，请调用 qmui_staticCellDataSource 的同名方法以保证功能的完整
    [tableView.qmui_staticCellDataSource didSelectRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
