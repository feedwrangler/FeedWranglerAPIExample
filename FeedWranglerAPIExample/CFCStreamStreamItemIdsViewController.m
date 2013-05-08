//
//  CFCStreamStreamItemIdsViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/8/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCStreamStreamItemIdsViewController.h"

@interface CFCStreamStreamItemIdsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *streamID;

@end

@implementation CFCStreamStreamItemIdsViewController

- (IBAction)loadStreamIds:(id)sender {
    [self.streamID resignFirstResponder];
    
    NSString* streamItemsURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/stream_item_ids?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    streamItemsURL = [streamItemsURL stringByAppendingFormat:@"&stream_id=%@", self.streamID.text];
    
    NSLog(@"Stream Items: %@", streamItemsURL);
    [self updateOutput:@""];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:streamItemsURL]];
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
