//
//  YYMovingRecordViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYMovingRecordViewController.h"
#import "YYGPSInfoRequest.h"
#import "YYRecordModel.h"
#import <MAMapKit/MAMapKit.h>

@interface YYMovingRecordViewController ()<MAMapViewDelegate>
{
     CLLocationCoordinate2D *coordinates;
}
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) MAAnimatedAnnotation* annotation;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong) NSArray<YYRecordModel *> *models;

@property (nonatomic,assign) CLLocationCoordinate2D lastCoordinate;

@property (nonatomic,assign) NSInteger lastIndex;

@property (nonatomic,strong) MAPolyline *currentPolyline;

@property (weak, nonatomic) IBOutlet UIButton *startButton;


@end

@implementation YYMovingRecordViewController


-(NSArray<YYRecordModel *> *)models
{
    if (_models == nil) {
        _models = [NSArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"轨迹";
    
    self.bottomView.layer.cornerRadius = 5;
    self.bottomView.layer.masksToBounds = YES;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    coordinates = NULL;
    
    [self.view insertSubview:self.mapView atIndex:0];
    
    [self requestTodayMovingRecord];
}


- (IBAction)recordButtonClick:(UIButton *)sender {
    if (self.currentPolyline) {
        for(MAAnnotationMoveAnimation *animation in [self.annotation allMoveAnimations]){
            [animation cancel];
        }
        [self.mapView removeAnnotation:self.annotation];
        [self.mapView removeOverlay:self.currentPolyline];
        self.startButton.selected = NO;
    }
    if (sender.selected) {
        [self requestTodayMovingRecord];
    }else{
        [self requestYesterdayMovingRecord];
    }
    sender.selected = !sender.selected;
}


-(void) requestYesterdayMovingRecord
{
    YYGPSInfoRequest *request = [[YYGPSInfoRequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kGPSInfoAPI];
    request.begin = @"2017-07-20 17:48:30";
    request.end = @"2017-07-21 00:00:00";
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            weakSelf.models = [YYRecordModel modelArrayWithDictArray:response];
            
            if (weakSelf.models.count <= 0) {
                return;
            }
            coordinates = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D) * weakSelf.models.count);
            
            int index = 0;
            for (YYRecordModel *model in weakSelf.models) {
                coordinates[index].longitude = model.lon;
                coordinates[index].latitude = model.lat;
                index++;
            }
            MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:weakSelf.models.count];
            weakSelf.currentPolyline = polyline;
            [weakSelf.mapView addOverlay:polyline];
            
            [weakSelf.mapView setCenterCoordinate:coordinates[0]];
            [weakSelf.mapView setZoomLevel:16.6];
            
            
            MAAnimatedAnnotation *anno = [[MAAnimatedAnnotation alloc] init];
            anno.coordinate = coordinates[0];
            weakSelf.annotation = anno;
            
            [weakSelf.mapView addAnnotation:weakSelf.annotation];
        }
    } error:^(NSError *error) {
        
    }];
}

-(void) requestTodayMovingRecord
{
    YYGPSInfoRequest *request = [[YYGPSInfoRequest alloc] init];
    request.nh_url = [NSString stringWithFormat:@"%@%@",kBaseURL,kGPSInfoAPI];
    request.begin = @"2017-07-20 17:48:30";
    request.end = @"2017-07-21 00:00:00";
    __weak __typeof(self)weakSelf = self;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            weakSelf.models = [YYRecordModel modelArrayWithDictArray:response];
            
            if (weakSelf.models.count <= 0) {
                return;
            }
            coordinates = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D) * weakSelf.models.count);
            
            int index = 0;
            for (YYRecordModel *model in weakSelf.models) {
                coordinates[index].longitude = model.lon;
                coordinates[index].latitude = model.lat;
                index++;
            }
            MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:weakSelf.models.count];
            weakSelf.currentPolyline = polyline;
            [weakSelf.mapView addOverlay:polyline];
            
            [weakSelf.mapView setCenterCoordinate:coordinates[0]];
            [weakSelf.mapView setZoomLevel:16.6];
            
            
            MAAnimatedAnnotation *anno = [[MAAnimatedAnnotation alloc] init];
            anno.coordinate = coordinates[0];
            weakSelf.annotation = anno;
            
            [weakSelf.mapView addAnnotation:weakSelf.annotation];
        }
    } error:^(NSError *error) {
        
    }];
}


/*!
 @brief  生成多角星坐标
 @param coordinates 输出的多角星坐标数组指针。内存需在外申请，方法内不释放，多角星坐标结果输出。
 @param pointsCount 输出的多角星坐标数组元素个数。
 @param starCenter  多角星的中心点位置。
 */
- (void)generateStarPoints:(CLLocationCoordinate2D *)coordinates pointsCount:(NSUInteger)pointsCount atCenter:(CLLocationCoordinate2D)starCenter
{
#define STAR_RADIUS 0.05
#define PI 3.1415926
    NSUInteger starRaysCount = pointsCount / 2;
    for (int i =0; i<starRaysCount; i++)
    {
        float angle = 2.f*i/starRaysCount*PI;
        int index = 2 * i;
        coordinates[index].latitude = STAR_RADIUS* sin(angle) + starCenter.latitude;
        coordinates[index].longitude = STAR_RADIUS* cos(angle) + starCenter.longitude;
        
        index++;
        angle = angle + (float)1.f/starRaysCount*PI;
        coordinates[index].latitude = STAR_RADIUS/2.f* sin(angle) + starCenter.latitude;
        coordinates[index].longitude = STAR_RADIUS/2.f* cos(angle) + starCenter.longitude;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)button1 {
    self.annotation.coordinate = coordinates[0];

    MAAnimatedAnnotation *anno = self.annotation;
    [anno addMoveAnimationWithKeyCoordinates:coordinates count:self.models.count withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
    
    }];
    
}




- (IBAction)startButtonClick:(UIButton *)sender {
    if (sender.selected) {
        QMUILog(@"%ld", [self.annotation allMoveAnimations].count);
        self.lastIndex = self.models.count - self.annotation.allMoveAnimations.count;
        for(MAAnnotationMoveAnimation *animation in [self.annotation allMoveAnimations]){
            [animation cancel];
        }
    }else{
        if (self.lastIndex == 0) {
            self.annotation.coordinate = coordinates[0];
            MAAnimatedAnnotation *anno = self.annotation;
            [anno addMoveAnimationWithKeyCoordinates:coordinates count:self.models.count withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
                sender.selected = NO;
                self.lastIndex = 0;
            }];
        }else{
            self.annotation.coordinate = coordinates[self.lastIndex];
            MAAnimatedAnnotation *anno = self.annotation;
            [anno addMoveAnimationWithKeyCoordinates:coordinates count:self.models.count withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
                sender.selected = NO;
                self.lastIndex = 0;
            }];
            
        }
     
//        if (self.lastCoordinate.longitude == 0 && self.lastCoordinate.latitude == 0) {
//            self.annotation.coordinate = coordinates[0];
//            MAAnimatedAnnotation *anno = self.annotation;
//            [anno addMoveAnimationWithKeyCoordinates:coordinates count:self.models.count withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
//                sender.selected = NO;
//                self.lastCoordinate = CLLocationCoordinate2DMake(0, 0);
//            }];
//        }else{
//            self.annotation.coordinate = self.lastCoordinate;
//            MAAnimatedAnnotation *anno = self.annotation;
//            [anno addMoveAnimationWithKeyCoordinates:coordinates count:[self.annotation allMoveAnimations].count withDuration:5 withName:nil completeCallback:^(BOOL isFinished) {
//                sender.selected = NO;
//
//            }];
//        }
    }
    sender.selected = !sender.selected;
}


#pragma mark - mapview delegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 8.f;
        [polylineRenderer setStrokeImage:[UIImage imageNamed:@"arrowTexture"]];
        return polylineRenderer;
        
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        NSString *pointReuseIndetifier = @"myReuseIndetifier";
        MAAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:pointReuseIndetifier];
            
            UIImage *imge  =  [UIImage imageNamed:@"userPosition"];
            annotationView.image =  imge;
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.draggable                    = NO;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
    
    return nil;
}
@end
