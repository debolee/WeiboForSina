//
//  WBNearbyTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/13.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBNearbyTableViewController.h"


@interface WBNearbyTableViewController ()

@end

@implementation WBNearbyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //开始获取设备当前位置信息
    self.manager = [[CLLocationManager alloc]init];
    [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.manager setDistanceFilter:10];
    self.manager.delegate = self;
    [self.manager requestAlwaysAuthorization];
    [self.manager startUpdatingLocation];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WBWeiboCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WBWeiboCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WBUserInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WBUserInfoCell"];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]init];
    backBarButtonItem.title = @"返回列表";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.toMapViewbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 45, self.view.bounds.size.height - 45, 30, 30)];
    [self.toMapViewbutton setBackgroundImage:[UIImage imageNamed:@"near_change_map"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:self.toMapViewbutton];
    [self.toMapViewbutton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.toMapViewbutton removeFromSuperview];
}

- (void) requestWeibos {
    //定位无效，模拟设备获取到的位置信息

    NSInteger endtime = [[NSDate date] timeIntervalSince1970];
    NSInteger starttime = endtime - 604800;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        [[WBWeiboAPI shareWeiboApi] requestNearbyTimeLineWithCoordinate:self.coord AndRange:10000 AndStarttime:starttime AndEndtime:endtime AndSort:1 AndCount:50 AndPage:1 AndBaseApp:0 AndOffSet:0 CompletionCallBack:^(id obj) {
            self.results = obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
}

//- (void) requestUserInfos {
//    CLLocationCoordinate2D coord;
//    coord.latitude = 23.143463;
//    coord.longitude = 113.347773;
//    NSInteger endtime = [[NSDate date] timeIntervalSince1970];
//    NSInteger starttime = endtime - 604800;
//    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
//        [[WBWeiboAPI shareWeiboApi] requestNearbyUsersWithCoordinate:coord AndRange:10000 AndStarttime:starttime AndEndtime:endtime AndSort:1 AndCount:50 AndPage:1 AndOffSet:0 CompletionCallBack:^(id obj) {
//            self.results = obj;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        }];
//    }
//}

- (void)buttonTap:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toMapVC" sender:sender];
}



- (IBAction)segmentValueChanged:(id)sender {
    
    UISegmentedControl * segment = sender;
    
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.Style = nearbyListViewStyleWeibo;
            [self.tableView reloadData];
            break;
        case 1:
            self.Style = nearbyListViewStyleUser;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
    
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败~~！！！");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    self.coord = newLocation.coordinate;
    
    //获取当前位置后发送获取附近微博的请求
    if (!self.results) {
        [self requestWeibos];
    }

    NSLog(@"coordinate : %f, %f", self.coord.latitude, self.coord.longitude);
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.Style == nearbyListViewStyleWeibo) {
        WBWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBWeiboCell" forIndexPath:indexPath];
        cell.weibo = [self.results objectAtIndex:indexPath.row];
        return cell;
    } else if (self.Style == nearbyListViewStyleUser) {
        WBUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBUserInfoCell" forIndexPath:indexPath];
        WBWeibo *weibo = [self.results objectAtIndex:indexPath.row];
        cell.user = weibo.user;
        return cell;
    } else
        return nil;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.Style == nearbyListViewStyleWeibo) {
        WBWeibo *weibo = self.results[indexPath.row];
        return [weibo getWeiboHeightIsDetailPage:NO]+110;
    } else if (self.Style == nearbyListViewStyleUser) {
        return 89;
    } else
        return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.Style == nearbyListViewStyleWeibo) {
        WBWeibo *weibo = [self.results objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"toDetailWeiboVC" sender:weibo];
        
    }


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toDetailWeiboVC"]) {
        WBDetailWeiboTableViewController *detailVC = [segue destinationViewController];
        detailVC.weibo = sender;
    } else if ([segue.identifier isEqualToString:@"toMapVC"]) {
        WBMapViewController *mapVC = [segue destinationViewController];
        if (self.Style == nearbyListViewStyleWeibo) {
            mapVC.Style = nearbyListViewStyleWeibo;
        } else {
            mapVC.Style = nearbyListViewStyleUser;
        }
        mapVC.results = self.results;
        mapVC.coord = self.coord;
    }

}


@end
