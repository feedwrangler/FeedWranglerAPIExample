//
//  CFCFeedItemsListViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsListViewController.h"

@interface CFCFeedItemsListViewController ()
@property (weak, nonatomic) IBOutlet UITextField *limitFilter;
@property (weak, nonatomic) IBOutlet UITextField *offsetFilter;
@property (weak, nonatomic) IBOutlet UITextField *feedID;

@property (weak, nonatomic) IBOutlet UITextField *createdFilter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *starredFilter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *readFilter;
@end

@implementation CFCFeedItemsListViewController

- (IBAction)loadFeedItems:(id)sender {
    [self.limitFilter resignFirstResponder];
    [self.offsetFilter resignFirstResponder];
    [self.feedID resignFirstResponder];
    [self.createdFilter resignFirstResponder];
    
    NSString* feedItemsURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/list?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    //Limit based on read status
    if(self.readFilter.selectedSegmentIndex == 1) {
        feedItemsURL = [feedItemsURL stringByAppendingString:@"&read=true"];
    }
    if(self.readFilter.selectedSegmentIndex == 2) {
        feedItemsURL = [feedItemsURL stringByAppendingString:@"&read=false"];
    }
    
    //Limit based on starred status
    if(self.starredFilter.selectedSegmentIndex == 1) {
        feedItemsURL = [feedItemsURL stringByAppendingString:@"&starred=true"];
    }
    if(self.starredFilter.selectedSegmentIndex == 2) {
        feedItemsURL = [feedItemsURL stringByAppendingString:@"&starred=false"];
    }
    
    //Limit based on published_at
    if(self.createdFilter.text.length > 0) {
        feedItemsURL = [feedItemsURL stringByAppendingFormat:@"&created_since=%@", self.createdFilter.text];
    }

    //Limit number of results
    if(self.limitFilter.text.length > 0) {
        feedItemsURL = [feedItemsURL stringByAppendingFormat:@"&limit=%@", self.limitFilter.text];
    }
    
    //Page Offset
    if(self.offsetFilter.text.length > 0) {
        feedItemsURL = [feedItemsURL stringByAppendingFormat:@"&offset=%@", self.offsetFilter.text];
    }

    //Feed ID filter
    if(self.feedID.text.length > 0) {
        feedItemsURL = [feedItemsURL stringByAppendingFormat:@"&feed_id=%@", self.feedID.text];
    }
    
    NSLog(@"Feed Items: %@", feedItemsURL);
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:feedItemsURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSError* jsonError = nil;
            NSDictionary* response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError != nil) {
                [self updateOutput:[jsonError description]];
            } else {
                [self updateOutput:[response description]];
            }
        } else {
            [self updateOutput:[error description]];
        }
    }];
    
    
}

@end
