//
//  WBDiscoverTableViewController.m
//  WeiboForSina
//
//  Created by BOBO on 15/6/3.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "WBDiscoverTableViewController.h"
#import "WBNearbyTableViewController.h"

@interface WBDiscoverTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchbar;
@property (nonatomic, strong) NSArray *results;
@end

@implementation WBDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"WBsearchSuggestionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WBsearchSuggestionCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"hotTopicsCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"hotTopicsCell1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"hotTopicsCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"hotTopicsCell2"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"nearbyCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"nearbyCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {

}



#pragma mark UISearchBarDelegate
- (void)searchWithString {
    switch (self.mySearchbar.selectedScopeButtonIndex) {
        case 0:
            //搜用户
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
                [[WBWeiboAPI shareWeiboApi] searchSuggestionsUsersWithString:self.mySearchbar.text AndCount:20 CompletionCallBack:^(id obj) {
                    self.results = obj;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"self.results.count :%ld", self.results.count);
                        [self.searchDisplayController.searchResultsTableView reloadData];
                    });
                    
                }];
            }
            break;
        case 1:
            //搜学校
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
                [[WBWeiboAPI shareWeiboApi] searchSuggestionsSchoolsWithString:self.mySearchbar.text AndCount:20 AndType:0 CompletionCallBack:^(id obj) {
                    self.results = obj;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"self.results.count :%ld", self.results.count);
                        [self.searchDisplayController.searchResultsTableView reloadData];
                    });
                }];
            }
            break;
        case 2:
            //搜公司
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
                [[WBWeiboAPI shareWeiboApi] searchSuggestionsCompaniesWithString:self.mySearchbar.text AndCount:20 CompletionCallBack:^(id obj) {
                    self.results = obj;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"self.results.count :%ld", self.results.count);
                        [self.searchDisplayController.searchResultsTableView reloadData];
                    });
                }];
            }
            break;
        default:
            break;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchWithString];
    
}


#pragma mark UISearchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    NSLog(@"WillBeginSearch....");
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    NSLog(@"DidBeginSearch....");
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    NSLog(@"WillEndSearch....");
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    NSLog(@"DidEndSearch....");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self searchWithString];
    return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self searchWithString];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//由于这个控制器既是原来的WBDiscoverTableViewController，又是UISearchDisplayController的searchContentsController。
//WBDiscoverTableViewController的tableView和searchResultsTableView的delegat都指向这个对象（self），
//所以需要在回调中区别到底是哪个tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView) {
        return 2;
    } else if (tableView == self.searchDisplayController.searchResultsTableView){
        return 1;
    } else
        return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView && section == 0) {
        return 2;
        
    } else if (tableView == self.tableView && section == 1) {
        return 1;
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.results.count;

    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.tableView) {
    
        if (indexPath.section == 0 && indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotTopicsCell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotTopicsCell2" forIndexPath:indexPath];
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearbyCell" forIndexPath:indexPath];
            return cell;
        }
        
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {

        WBsearchSuggestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBsearchSuggestionCell" forIndexPath:indexPath];
        id result = self.results[indexPath.row];
        
        if ([result isMemberOfClass:[WBSearchSuggestionsOfUsers class]]) {
            WBSearchSuggestionsOfUsers * suggestion = result;
            cell.suggestion.text = suggestion.nickName;
        } else if ([result isMemberOfClass:[WBSearchSuggestionsOfSchools class]]) {
            WBSearchSuggestionsOfSchools *suggestion = result;
            cell.suggestion.text = suggestion.schoolName;
            
        } else {
            WBSearchSuggestionsOfCompanies *suggestion = result;
            cell.suggestion.text = suggestion.suggestion;
        }
        return cell;
    } else
        return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.tableView == tableView && indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toNearbyVC" sender:nil];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toNearbyVC"]) {
        WBNearbyTableViewController *nearbyVC = [segue destinationViewController];
        nearbyVC.Style = nearbyListViewStyleWeibo;
        
    }
}


@end
