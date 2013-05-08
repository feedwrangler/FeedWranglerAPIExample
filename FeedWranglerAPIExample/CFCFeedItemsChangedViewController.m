//
//  CFCFeedItemsChangedViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/8/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsChangedViewController.h"

@interface CFCFeedItemsChangedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *createdFilter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *starredFilter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *readFilter;
@end

@implementation CFCFeedItemsChangedViewController

- (IBAction)loadFeedItems:(id)sender {
    [self.createdFilter resignFirstResponder];
    
    NSString* feedItemsURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/changed?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
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
        feedItemsURL = [feedItemsURL stringByAppendingFormat:@"&updated_since=%@", self.createdFilter.text];
    }
    
    
    NSLog(@"Changed Feed Items: %@", feedItemsURL);
    [self updateOutput:@""];
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
