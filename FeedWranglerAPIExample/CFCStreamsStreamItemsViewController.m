//
//  CFCStreamsStreamItemsViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCStreamsStreamItemsViewController.h"

@interface CFCStreamsStreamItemsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *streamID;
@property (weak, nonatomic) IBOutlet UITextField *limitFilter;
@property (weak, nonatomic) IBOutlet UITextField *offsetFilter;

@end

@implementation CFCStreamsStreamItemsViewController

- (IBAction)loadStreamItems:(id)sender {

    [self.limitFilter resignFirstResponder];
    [self.offsetFilter resignFirstResponder];
    [self.streamID resignFirstResponder];
    
    NSString* streamItemsURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/stream_items?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    //Limit number of results
    if(self.limitFilter.text.length > 0) {
        streamItemsURL = [streamItemsURL stringByAppendingFormat:@"&limit=%@", self.limitFilter.text];
    }
    
        //Page Offset
    if(self.offsetFilter.text.length > 0) {
        streamItemsURL = [streamItemsURL stringByAppendingFormat:@"&offset=%@", self.offsetFilter.text];
    }
    
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
