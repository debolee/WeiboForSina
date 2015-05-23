//
//  WBDetailWeiboTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/15.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBDetailWeiboTableViewController.h"
#import "WBCommentCell.h"

@interface WBDetailWeiboTableViewController ()

@end

@implementation WBDetailWeiboTableViewController

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

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.detailWeiboHeaderView.weibo = self.weibo;
    self.detailWeiboHeaderView.backgroundColor = [UIColor redColor];
    self.detailWeiboHeaderView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, [self.weibo getWeiboHeightIsDetailPage:YES] + 110);
    
    self.tableView.tableHeaderView = self.detailWeiboHeaderView;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        [[WBWeiboAPI shareWeiboApi] requestCommentsByWeiboId:self.weibo.weiboId WithPageNumber:1 completionCallBack:^(id obj) {
            self.comments = obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    cell.comment = self.comments[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBComment *comment = [self.comments objectAtIndex:indexPath.row];
    float height = [comment getCommentHeightWithWidth:self.tableView.frame.size.width - 62];
    
//    float height= [comment getCommentHeight];
//    float height = 100;
    NSLog(@"height is :%f", height);
    return height + 65;
}

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
