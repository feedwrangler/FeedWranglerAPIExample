//
//  CFCFeedItemsGetViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/8/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsGetViewController.h"

@interface CFCFeedItemsGetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *feedItemIds;

@end

@implementation CFCFeedItemsGetViewController

- (IBAction)getItems:(id)sender {
    
    [self.feedItemIds resignFirstResponder];
    
    NSString* getURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/get?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    getURL = [getURL stringByAppendingFormat:@"&feed_item_ids=%@", [self encodeText:self.feedItemIds.text]];
    
    NSLog(@"Get Items: %@", getURL);
    [self updateOutput:@""];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:getURL]];
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
