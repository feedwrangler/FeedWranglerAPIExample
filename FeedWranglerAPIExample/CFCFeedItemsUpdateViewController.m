//
//  CFCFeedItemsUpdateViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsUpdateViewController.h"

@interface CFCFeedItemsUpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *feedItemID;
@property (weak, nonatomic) IBOutlet UISegmentedControl *updateStarred;
@property (weak, nonatomic) IBOutlet UISegmentedControl *updateRead;
@property (weak, nonatomic) IBOutlet UISegmentedControl *updateReadLater;

@end

@implementation CFCFeedItemsUpdateViewController


- (IBAction)updateFeedItem:(id)sender {
    [self.feedItemID resignFirstResponder];
    
    NSString* feedItemUpdateURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/update?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    feedItemUpdateURL = [feedItemUpdateURL stringByAppendingFormat:@"&feed_item_id=%@", self.feedItemID.text];
    
    //Update read status
    if(self.updateRead.selectedSegmentIndex == 1) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&read=true"];
    }
    if(self.updateRead.selectedSegmentIndex == 2) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&read=false"];
    }
    
    //Update starred
    if(self.updateStarred.selectedSegmentIndex == 1) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&starred=true"];
    }
    if(self.updateStarred.selectedSegmentIndex == 2) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&starred=false"];
    }

    //Update read_later
    if(self.updateReadLater.selectedSegmentIndex == 1) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&read_later=true"];
    }
    if(self.updateReadLater.selectedSegmentIndex == 2) {
        feedItemUpdateURL = [feedItemUpdateURL stringByAppendingString:@"&read_later=false"];
    }
    
    NSLog(@"Update Feed Item: %@", feedItemUpdateURL);
    [self updateOutput:@""];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:feedItemUpdateURL]];
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
