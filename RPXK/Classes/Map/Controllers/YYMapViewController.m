//
//  YYMapViewController.m
//  RPXK
//
//  Created by yunyuchen on 2017/9/28.
//  Copyright © 2017年 yunyuchen. All rights reserved.
//

#import "YYMapViewController.h"
#import "YYMovingRecordViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface YYMapViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *locationView;


@end

@implementation YYMapViewController


- (BOOL)shouldCustomNavigationBarTransitionIfBarHiddenable
{
    return YES;
}

-(BOOL) preferredNavigationBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前定位";
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordButton setTitle:@"轨迹" forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [recordButton sizeToFit];
    [recordButton addTarget:self action:@selector(recordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordButton];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    // 开启定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView setZoomLevel:15.6];
    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
    represent.showsAccuracyRing = YES;
    represent.showsHeadingIndicator = YES;
    represent.image = [UIImage imageNamed:@"userPosition"];
    [self.mapView updateUserLocationRepresentation:represent];
    [self.view insertSubview:self.mapView atIndex:0];
        
    self.locationView.layer.cornerRadius = 5;
    self.locationView.layer.masksToBounds = YES;
}

-(void) recordButtonClick:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"moving" sender:self];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation)
    {
        MAAnnotationView *userLocationView = [mapView viewForAnnotation:mapView.userLocation];
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            userLocationView.imageView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}

@end
