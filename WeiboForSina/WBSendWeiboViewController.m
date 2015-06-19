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

//    创建inputAccessoryView
    
    self.toolbarAccView = [[UIView alloc]init];
    self.toolbarAccView.backgroundColor = [UIColor clearColor];
    self.toolbarAccView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 62);
    
    //显示位置按钮
    UIButton *locationButton = [[UIButton alloc]init];
    locationButton.frame = CGRectMake(8, 0, 60, 20);
    [locationButton setTitle:@"显示位置" forState:UIControlStateNormal];
    [locationButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    locationButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
    locationButton.layer.cornerRadius = 10;
    locationButton.layer.masksToBounds = YES;
    
    //是否公开按钮
    UIButton *pubButton = [[UIButton alloc]init];
    pubButton.frame = CGRectMake(252, 0, 60, 20);
    [pubButton setTitle:@"公开" forState:UIControlStateNormal];
    [pubButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [pubButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pubButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    pubButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
    pubButton.layer.cornerRadius = 10;
    pubButton.layer.masksToBounds = YES;
    
    UIView *toolBarView =[[UIView alloc]initWithFrame:CGRectMake(0, 22, self.view.bounds.size.width, 40)];
    toolBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background@2x"]];
    
    UIButton *pictureButton = [[UIButton alloc]init];
    pictureButton.frame = CGRectMake(8, 0, 40, 40);
    [pictureButton setImage:[UIImage imageNamed:@"toolbar_send_picturebutton"] forState:UIControlStateNormal];
    [pictureButton setImage:[UIImage imageNamed:@"toolbar_send_picturebutton_selected"] forState:UIControlStateHighlighted];
    
    [toolBarView addSubview:pictureButton];
    
    [self.toolbarAccView addSubview:locationButton];
    [self.toolbarAccView addSubview:pubButton];
    [self.toolbarAccView addSubview:toolBarView];
    self.weiboTextView.inputAccessoryView = self.toolbarAccView;
    
    
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
