//
//  CFCSubscriptionsRemoveFeedViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCSubscriptionsRemoveFeedViewController.h"

@interface CFCSubscriptionsRemoveFeedViewController ()

@property (weak, nonatomic) IBOutlet UITextField *feedID;
@end

@implementation CFCSubscriptionsRemoveFeedViewController

- (IBAction)unsubscribe:(id)sender {
    [self.feedID resignFirstResponder];
    NSString* removeSubscriptionURL = [API_URL_PREFIX stringByAppendingFormat:@"subscriptions/remove_feed?access_token=%@&feed_id=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"], [self encodeText:self.feedID.text]];
    NSLog(@"Remove Subscription: %@", removeSubscriptionURL);
    [self updateOutput:@""];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:removeSubscriptionURL]];
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
