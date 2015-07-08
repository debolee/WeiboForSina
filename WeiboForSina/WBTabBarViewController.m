//
//  WBTabBarViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBTabBarViewController.h"

@interface WBTabBarViewController ()

@end

@implementation WBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = self.tabBar.bounds;
    WBTabBar *myTabBar = [[WBTabBar alloc]init];
    myTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    myTabBar.frame = frame;
    myTabBar.delegate = self;
    
    //添加按钮
    UIImage *normalImage0 = [UIImage imageNamed:@"tabbar_home"];
    UIImage *normalImage1 = [UIImage imageNamed:@"tabbar_message_center"];
    UIImage *normalImage2 = [UIImage imageNamed:@"tabbar_compose_icon_add"];
    UIImage *normalImage3 = [UIImage imageNamed:@"tabbar_discover"];
    UIImage *normalImage4 = [UIImage imageNamed:@"tabbar_profile"];
    
    UIImage *selectedImage0 = [UIImage imageNamed:@"tabbar_home_selected"];
    UIImage *selectedImage1 = [UIImage imageNamed:@"tabbar_message_center_selected"];
    UIImage *selectedImage2 = [UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"];
    UIImage *selectedImage3 = [UIImage imageNamed:@"tabbar_discover_selected"];
    UIImage *selectedImage4 = [UIImage imageNamed:@"tabbar_profile_selected"];
    
    NSArray *normalImages = @[normalImage0, normalImage1, normalImage2, normalImage3, normalImage4];
    NSArray *selectedImages = @[selectedImage0, selectedImage1, selectedImage2, selectedImage3, selectedImage4];
    
    [myTabBar addButtonWithNormalImages:normalImages AndSelectedImages:selectedImages];

    [self.tabBar addSubview:myTabBar];
    
    
}

#pragma mark - WBTabBarDelegate
- (void) tabBar:(WBTabBar *)tabBar selectedFromButton:(NSInteger)fromTag toButton:(NSInteger)toTag {
    switch (toTag) {
        case 0:
            self.selectedIndex = 0;
            break;
        case 1:
            self.selectedIndex = 1;
            break;
        case 2:
            [self performSegueWithIdentifier:@"toSendWeiboVC" sender:nil];
            break;
        case 3:
            self.selectedIndex = 2;
            break;
        case 4:
            self.selectedIndex = 3;
            break;
        default:
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
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
