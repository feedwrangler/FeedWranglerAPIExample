//
//  CFCMasterViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCActionsViewController.h"
#import "CFCUsersLoginViewController.h"
#import "CFCUsersLogoutViewController.h"
#import "CFCSubscriptionsListViewController.h"
#import "CFCSubscriptionsAddFeedViewController.h"
#import "CFCSubscriptionsRemoveFeedViewController.h"
#import "CFCFeedItemsListViewController.h"
#import "CFCFeedItemsUpdateViewController.h"
#import "CFCFeedItemsMarkAllReadViewController.h"
#import "CFCStreamsListViewController.h"
#import "CFCStreamsStreamItemsViewController.h"
#import "CFCFeedItemsSearchViewController.h"
#import "CFCFeedItemsChangedViewController.h"
#import "CFCFeedItemsGetViewController.h"
#import "CFCStreamStreamItemIdsViewController.h"
#import "CFCFeedItemsListIdsViewController.h"
#import "CFCStreamsCreateUpdateViewController.h"

@interface CFCActionsViewController ()

@end

@implementation CFCActionsViewController
							
#pragma mark - Table View

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feed Wrangler";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"/users";
    }
    if(section == 1) {
        return @"/subscriptions";
    }
    if(section == 2) {
        return @"/feed_items";
    }
    if(section == 3) {
        return @"/streams";
    }

    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }

    if (section == 1) {
        return 3;
    }

    if (section == 2) {
        return 7;
    }

    if (section == 3) {
        return 4;
    }

    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if(indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"Login";
    }
    if(indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"Logout";
    }

    if(indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"List Subscriptions";
    }
    if(indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"Add Subscription";
    }
    if(indexPath.section == 1 && indexPath.row == 2) {
        cell.textLabel.text = @"Remove Subscription";
    }


    if(indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"Get Feed Items";
    }
    if(indexPath.section == 2 && indexPath.row == 1) {
        cell.textLabel.text = @"Get Changed Item IDs";
    }
    if(indexPath.section == 2 && indexPath.row == 2) {
        cell.textLabel.text = @"Update Feed Item";
    }
    if(indexPath.section == 2 && indexPath.row == 3) {
        cell.textLabel.text = @"Mark All Feed Items Read";
    }
    if(indexPath.section == 2 && indexPath.row == 4) {
        cell.textLabel.text = @"Search for Feed Items";
    }
    if(indexPath.section == 2 && indexPath.row == 5) {
        cell.textLabel.text = @"Get Specific Feed Items";
    }
    if(indexPath.section == 2 && indexPath.row == 6) {
        cell.textLabel.text = @"Get Feed Item IDs";
    }

    
    if(indexPath.section == 3 && indexPath.row == 0) {
        cell.textLabel.text = @"List Streams";
    }
    if(indexPath.section == 3 && indexPath.row == 1) {
        cell.textLabel.text = @"Get Stream Items";
    }
    if(indexPath.section == 3 && indexPath.row == 2) {
        cell.textLabel.text = @"Get Stream Item IDs";
    }
    if(indexPath.section == 3 && indexPath.row == 3) {
        cell.textLabel.text = @"Create/Update Stream";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        self.detailViewController = [[CFCUsersLoginViewController alloc] initWithNibName:@"CFCUsersLoginViewController" bundle:nil];
    }
    if(indexPath.section == 0 && indexPath.row == 1) {
        self.detailViewController = [[CFCUsersLogoutViewController alloc] initWithNibName:@"CFCUsersLogoutViewController" bundle:nil];
    }
    
    if(indexPath.section == 1 && indexPath.row == 0) {
        self.detailViewController = [[CFCSubscriptionsListViewController alloc] initWithNibName:@"CFCSubscriptionsListViewController" bundle:nil];
    }
    if(indexPath.section == 1 && indexPath.row == 1) {
        self.detailViewController = [[CFCSubscriptionsAddFeedViewController alloc] initWithNibName:@"CFCSubscriptionsAddFeedViewController" bundle:nil];
    }
    if(indexPath.section == 1 && indexPath.row == 2) {
        self.detailViewController = [[CFCSubscriptionsRemoveFeedViewController alloc] initWithNibName:@"CFCSubscriptionsRemoveFeedViewController" bundle:nil];
    }

    if(indexPath.section == 2 && indexPath.row == 0) {
        self.detailViewController = [[CFCFeedItemsListViewController alloc] initWithNibName:@"CFCFeedItemsListViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 1) {
        self.detailViewController = [[CFCFeedItemsChangedViewController alloc] initWithNibName:@"CFCFeedItemsChangedViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 2) {
        self.detailViewController = [[CFCFeedItemsUpdateViewController alloc] initWithNibName:@"CFCFeedItemsUpdateViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 3) {
        self.detailViewController = [[CFCFeedItemsMarkAllReadViewController alloc] initWithNibName:@"CFCFeedItemsMarkAllReadViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 4) {
        self.detailViewController = [[CFCFeedItemsSearchViewController alloc] initWithNibName:@"CFCFeedItemsSearchViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 5) {
        self.detailViewController = [[CFCFeedItemsGetViewController alloc] initWithNibName:@"CFCFeedItemsGetViewController" bundle:nil];
    }
    if(indexPath.section == 2 && indexPath.row == 6) {
        self.detailViewController = [[CFCFeedItemsListIdsViewController alloc] initWithNibName:@"CFCFeedItemsListIdsViewController" bundle:nil];
    }
    
    
    if(indexPath.section == 3 && indexPath.row == 0) {
        self.detailViewController = [[CFCStreamsListViewController alloc] initWithNibName:@"CFCStreamsListViewController" bundle:nil];
    }
    if(indexPath.section == 3 && indexPath.row == 1) {
        self.detailViewController = [[CFCStreamsStreamItemsViewController alloc] initWithNibName:@"CFCStreamsStreamItemsViewController" bundle:nil];
    }
    if(indexPath.section == 3 && indexPath.row == 2) {
        self.detailViewController = [[CFCStreamStreamItemIdsViewController alloc] initWithNibName:@"CFCStreamStreamItemIdsViewController" bundle:nil];
    }

    if(indexPath.section == 3 && indexPath.row == 3) {
        self.detailViewController = [[CFCStreamsCreateUpdateViewController alloc] initWithNibName:@"CFCStreamsCreateUpdateViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
