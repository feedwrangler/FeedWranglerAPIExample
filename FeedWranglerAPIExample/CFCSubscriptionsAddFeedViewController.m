//
//  CFCSubscriptionsAddFeedViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCSubscriptionsAddFeedViewController.h"

@interface CFCSubscriptionsAddFeedViewController ()

@property (weak, nonatomic) IBOutlet UITextField *feedURL;
@property (weak, nonatomic) IBOutlet UISwitch *chooseFirstSwitch;

@end

@implementation CFCSubscriptionsAddFeedViewController

- (IBAction)addAndWaitFeed:(id)sender {
    [self.feedURL resignFirstResponder];

    NSString* addSubscriptionURL = [API_URL_PREFIX stringByAppendingFormat:@"subscriptions/add_feed_and_wait?access_token=%@&feed_url=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"], [self encodeText:self.feedURL.text]];
    
   addSubscriptionURL = [addSubscriptionURL stringByAppendingFormat:@"&choose_first=%@", (self.chooseFirstSwitch.on ? @"true" : @"false")];
    
    NSLog(@"Add Subscription And Wait: %@", addSubscriptionURL);
    [self updateOutput:@""];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:addSubscriptionURL]];
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

- (IBAction)addFeed:(id)sender {
    [self.feedURL resignFirstResponder];
    NSString* addSubscriptionURL = [API_URL_PREFIX stringByAppendingFormat:@"subscriptions/add_feed?access_token=%@&feed_url=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"], [self encodeText:self.feedURL.text]];
    NSLog(@"Add Subscription: %@", addSubscriptionURL);
    [self updateOutput:@""];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:addSubscriptionURL]];
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
