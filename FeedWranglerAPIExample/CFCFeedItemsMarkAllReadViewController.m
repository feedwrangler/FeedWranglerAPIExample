//
//  CFCFeedItemsMarkAllReadViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsMarkAllReadViewController.h"

@interface CFCFeedItemsMarkAllReadViewController ()

@property (weak, nonatomic) IBOutlet UITextField *feedID;
@property (weak, nonatomic) IBOutlet UITextField *createdOnOrBefore;

@end

@implementation CFCFeedItemsMarkAllReadViewController

- (IBAction)markAllRead:(id)sender {
    [self.feedID resignFirstResponder];
    [self.createdOnOrBefore resignFirstResponder];
    
    NSString* markAllReadURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/mark_all_read?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    //Update particular Feed
    if(self.feedID.text.length > 0) {
        markAllReadURL = [markAllReadURL stringByAppendingFormat:@"&feed_id=%@", self.feedID.text];
    }
    
    //Update items created on or before
    if(self.createdOnOrBefore.text.length > 0) {
        markAllReadURL = [markAllReadURL stringByAppendingFormat:@"&created_on_before=%@", self.createdOnOrBefore.text];
    }
    
    NSLog(@"Mark Items Read: %@", markAllReadURL);
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:markAllReadURL]];
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
