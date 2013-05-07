//
//  CFCStreamsListViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCStreamsListViewController.h"

@interface CFCStreamsListViewController ()

@end

@implementation CFCStreamsListViewController

- (IBAction)loadStreams:(id)sender {

    NSString* streamsURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/list?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    NSLog(@"Load Streams: %@", streamsURL);
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:streamsURL]];
    [self updateOutput:@""];
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
