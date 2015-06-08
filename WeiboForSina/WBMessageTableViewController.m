//
//  WBMessageTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/29.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBMessageTableViewController.h"

@interface WBMessageTableViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@end

@implementation WBMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
#warning 微博消息接口需要申请，暂未实现，模拟对话列表中的用户信息
    UIImage *image = [UIImage imageNamed:@"icon"];
    
    NSDictionary *message = [[NSDictionary alloc]initWithObjectsAndKeys:@"今天好像要下大暴雨哦，你带伞了吗?", @"message",@"微博客服",@"nickName", image,@"image",nil];
    
    self.messages = [NSMutableArray array];
    [self.messages addObject:message];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.messages.count + 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"messageAtCell" forIndexPath:indexPath];
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"messageCommentCell" forIndexPath:indexPath];
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"messageGoodCell" forIndexPath:indexPath];
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"messageBoxCell" forIndexPath:indexPath];
        }
            break;
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"chatListCell" forIndexPath:indexPath];
            WBChatListCell *chatListCell = (WBChatListCell *)cell;
            chatListCell.message = self.messages[indexPath.row - 4];
        }
            break;
    }
    
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
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
