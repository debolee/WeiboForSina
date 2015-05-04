//
//  WBUserInfoHomeTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/1.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBUserInfoHomeTableViewController.h"
#import "WBAppDelegate.h"
#import "WBUserInfo.h"
#import "WBJsonParser.h"

@interface WBUserInfoHomeTableViewController ()
@property (nonatomic, weak)WBAppDelegate *appDelegate;
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
    self.appDelegate = (WBAppDelegate *)[UIApplication sharedApplication].delegate;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.portraitImage.layer.cornerRadius = 40;
    self.portraitImage.layer.masksToBounds = YES;
    self.portraitImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.portraitImage.layer.borderWidth = 2.0;
    
    if (!self.appDelegate.wbToken) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self login];
        });
    } else {
        
        [WBHttpRequest requestWithAccessToken:self.appDelegate.wbToken url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid": self.appDelegate.wbCurrentUserID} delegate:self withTag:nil];
        
    }

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
    
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败！！！！！！！！");
}



- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
//    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"dada String is :%@", str);
    self.userInfo = [WBJsonParser parseUserInfoWithDada:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateUI];
    });

}


#pragma mark 授权验证
- (void)login {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WBAppRedirectURL;
    request.scope = @"all";
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
