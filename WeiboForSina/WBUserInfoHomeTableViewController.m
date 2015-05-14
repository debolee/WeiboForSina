//
//  WBUserInfoHomeTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/1.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBUserInfoHomeTableViewController.h"


@interface WBUserInfoHomeTableViewController ()
//@property (nonatomic, weak)WBAppDelegate *appDelegate;
@property (nonatomic, strong)WBUserInfo *userInfo;

@end

@implementation WBUserInfoHomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.portraitImage.layer.cornerRadius = 40;
    self.portraitImage.layer.masksToBounds = YES;
    self.portraitImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.portraitImage.layer.borderWidth = 2.0;

//    self.appDelegate = (WBAppDelegate *)[UIApplication sharedApplication].delegate;

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置导航栏为透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    ((WBAppDelegate *)[UIApplication sharedApplication].delegate).wbdelegate = self;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self login];
//            NSLog(@"login方法执行了。。。。。。。。。");
        });
    } else {
        [self requestUserInfo];
//        NSLog(@"requestUserInfo方法执行了。。。。。。。。。");
    }
    
        NSLog(@"viewWillAppear方法执行了。。。。。。。。。");
}


#pragma mark 授权验证
- (void)login {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WBAppRedirectURL;
    request.scope = @"all";
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
}

//发送获取用户信息的请求
- (void)requestUserInfo {
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    [WBHttpRequest requestWithAccessToken:accessToken url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":userID} delegate:self withTag:nil];
}

#pragma  mark forCallBackDidReceiveWeiboResponseDelegate
//登录完成获取token后回调此方法刷新界面
- (void)CallBackDidReceiveWeiboResponse:(id)obj {
    [self requestUserInfo];
}


- (void)updateUI {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *coverImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.userInfo.coverImagePath]];
        UIImage *coverImage = [UIImage imageWithData:coverImageData];
        
        NSData *portraitImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.userInfo.portraitImagePath]];
        UIImage *portraitImage = [UIImage imageWithData:portraitImageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.coverImage.image = coverImage;
            self.portraitImage.image = portraitImage;
        });
        
    });
    
    self.nickName.text = self.userInfo.nickName;
    self.site.text = self.userInfo.site;
    self.simplyIntroduction.text = self.userInfo.introduction;
    self.detailIntroduction.text = self.userInfo.introduction;
    NSString *followerStr = self.userInfo.followerCount;
    NSString *fansStr = self.userInfo.fanscount;
    [self.followerCount setTitle:[NSString stringWithFormat:@"关注：%@", followerStr] forState:UIControlStateNormal];
    [self.fansCount setTitle:[NSString stringWithFormat:@"粉丝：%@", fansStr] forState:UIControlStateNormal];
}


#pragma mark WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"NSURLResponse is 请求成功！");
//    NSLog(@"response:%@",response);
    
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"请求失败！！！！！！！！%d",error.code);
    NSLog(@"error :%@",[error localizedDescription]);
    NSLog(@"error :%@",[error localizedFailureReason]);
    NSLog(@"error :%@",[error localizedRecoverySuggestion]);
    
    NSString *message;
    if (error.code == -1009) {
        message = @"网络连接好像断开了！";
    } else {
        message = @"数据请求失败，请稍后重试！";
    }
    
    UIAlertView *WBalertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [WBalertView show];
}


- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
//    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"dada String is :%@", str);
    self.userInfo = [WBJsonParser parseUserInfoByData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateUI];
    });

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 120.0;
    } else {
        return 0;
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
