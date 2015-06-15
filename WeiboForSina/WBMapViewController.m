//
//  WBMapViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/14.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBMapViewController.h"

@interface WBMapViewController ()
@property (nonatomic, strong) UIButton *toMapViewbutton;
@end

@implementation WBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.toMapViewbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 45, self.view.bounds.size.height - 45, 30, 30)];
    [self.toMapViewbutton setBackgroundImage:[UIImage imageNamed:@"near_change_list"] forState:UIControlStateNormal];
    [self.view addSubview:self.toMapViewbutton];
    [self.toMapViewbutton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    

    for (WBWeibo *weibo in self.results) {
        WBAnnotation *Ann = [[WBAnnotation alloc]init];
        [Ann setCoordinate:weibo.coord];
        Ann.weibo = weibo;
        [self.mapView addAnnotation:Ann];
    }

    
    //地图的显示精度，数值越小地图显示越详细
    MKCoordinateSpan span;
    span.longitudeDelta = 0.005;
    span.latitudeDelta = 0.005;
    
    WBWeibo *weibo = [self.results objectAtIndex:0];
    CLLocationCoordinate2D coord = weibo.coord;
    
    [self.mapView setRegion:MKCoordinateRegionMake(coord, span) animated:YES];
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

#warning TODO 当dismiss地图控制器后再次进入，偶尔界面卡死
    NSLog(@"viewForAnnotation...... ");
    if (self.Style == nearbyListViewStyleWeibo) {
        static NSString *weiboAnnID = @"weiboAnnID";
        WBWeiboAnnotationView *weiboAnnView = (WBWeiboAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:weiboAnnID];
        if (!weiboAnnView) {
            weiboAnnView = [[WBWeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:weiboAnnID];
        }
        return weiboAnnView;
    } else if (self.Style == nearbyListViewStyleUser) {
        static NSString *userAnnID = @"userAnnID";
        WBUserAnnotationView *userAnnView = (WBUserAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:userAnnID];
        if (!userAnnView) {
            userAnnView = [[WBUserAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:userAnnID];
        }
        return userAnnView;
    } else
        return nil;

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.toMapViewbutton removeFromSuperview];
}

- (void)buttonTap:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:self completion:nil];
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

@end
