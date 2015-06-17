//
//  WBSendWeiboViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/17.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBSendWeiboViewController.h"

@interface WBSendWeiboViewController ()

@end

@implementation WBSendWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cannelButtonClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)sendButtonClick:(UIBarButtonItem *)sender {
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
