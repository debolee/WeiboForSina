//
//  WBHomeTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/5/9.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "WBDetailWeiboTableViewController.h"
#import "WBDropdownMenuView.h"
#import "WBTitleMenuViewController.h"

@interface WBHomeTableViewController () <WBDropdownMenuViewDelegate,WBTitleMenuDelegate>
@property (nonatomic, strong)NSMutableArray *weibos;

@end

@implementation WBHomeTableViewController

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
    self.weibos = [[NSMutableArray alloc]init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
//    self.title = @"首页";
    [self.tableView registerNib:[UINib nibWithNibName:@"WBWeiboCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WBWeiboCell"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"首页" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.titleView = [self titleViewWithTitleStr:@"选择分组"];

}


#pragma mark 1.设置导航栏中间titleView
- (UIButton *) titleViewWithTitleStr:(NSString *) title {
    UIButton *titleButton = [[UIButton alloc]init];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateHighlighted];
    
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 130这个值目前是随便写的，后面要改为根据内容自动计算长度
    titleButton.frame = CGRectMake(titleButton.frame.origin.x, titleButton.frame.origin.y, 130, 40);
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return titleButton;
}

#pragma mark 2.添加导航栏中间titleButton的点击事件,弹出下拉菜单
- (void)titleClick:(UIButton *)titleButton {


    WBDropdownMenuView *dropdownMenuView = [[WBDropdownMenuView alloc]init];
    dropdownMenuView.delegate = self;
    
    WBTitleMenuViewController *titleMenuVC = [[WBTitleMenuViewController alloc]init];
//    titleMenuVC.view.frame = CGRectMake(titleMenuVC.view.frame.origin.x, titleMenuVC.view.frame.origin.y, self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    
    [dropdownMenuView showFrom:titleButton];
    
    titleMenuVC.dropdownMenuView = dropdownMenuView;
    titleMenuVC.delegate = self;
    dropdownMenuView.contentController = titleMenuVC;
    
    NSLog(@"titleClick:(UIButton *)titleButton。。。。");
}

#pragma mark 3.WBDropdownMenuViewDelegate
- (void)dropdownMenuDidDismiss:(WBDropdownMenuView *)menu {
    // 让指示箭头向上
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

#pragma mark - 4.TitleMenuDelegate
-(void)selectAtIndexPath:(NSIndexPath *)indexPath title:(NSString *)title
{
    NSLog(@"indexPath = %ld", indexPath.row);
    NSLog(@"当前选择了%@", title);
    
    // 修改导航栏的标题
    [(UIButton *)self.navigationItem.titleView setTitle:title forState:UIControlStateNormal];
    
    // 调用根据搜索条件返回相应的微博数据
    // ...
}


#pragma mark 获取最新微博
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        [[WBWeiboAPI shareWeiboApi] requestHomeTimeLineWithPageNumber:1 completionCallBack:^(id obj) {
            self.weibos = obj;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            NSLog(@"self.tableView reloadData!!!");
        }];
    }
    

}


- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.toolbar.frame = CGRectMake(self.navigationController.toolbar.frame.origin.x, self.view.bounds.size.height - 44, self.navigationController.toolbar.frame.size.width, self.navigationController.toolbar.bounds.size.height);
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
    
    NSLog(@"self.weibos.count :%ld",self.weibos.count);
    return self.weibos.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBWeiboCell" forIndexPath:indexPath];
    
    NSLog(@"cell is cell...!!!");
    cell.weibo = [self.weibos objectAtIndex:indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBWeibo *weibo = self.weibos[indexPath.row];
    
    return [weibo getWeiboHeightIsDetailPage:NO]+110;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WBWeibo *weibo = [self.weibos objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toDetailWeiboVC" sender:weibo];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetailWeiboVC"]) {
        
        WBDetailWeiboTableViewController *dvc = [segue destinationViewController];
        dvc.weibo = (WBWeibo *)sender;
    }
}


@end
