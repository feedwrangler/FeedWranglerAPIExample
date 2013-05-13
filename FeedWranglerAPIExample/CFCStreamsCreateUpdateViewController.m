//
//  CFCStreamsCreateViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/13/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCStreamsCreateUpdateViewController.h"

@interface CFCStreamsCreateUpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *streamTitle;
@property (weak, nonatomic) IBOutlet UITextField *searchTerm;
@property (weak, nonatomic) IBOutlet UISwitch *allFeedsSwitch;
@property (weak, nonatomic) IBOutlet UITextField *feedIDs;
@property (weak, nonatomic) IBOutlet UISwitch *onlyUnreadSwitch;
@property (weak, nonatomic) IBOutlet UITextField *streamID;

@end

@implementation CFCStreamsCreateUpdateViewController


- (IBAction)destroyStream:(id)sender {
    
    if(self.streamID.text.length == 0) {
        [self updateOutput:@"Missing Stream ID"];
        return;
    }
    
    [self.streamTitle resignFirstResponder];
    [self.searchTerm resignFirstResponder];
    [self.feedIDs resignFirstResponder];
    [self.streamID resignFirstResponder];

    NSString* streamURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/destroy?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    streamURL = [streamURL stringByAppendingFormat:@"&stream_id=%@", [self encodeText:self.streamID.text]];
    NSLog(@"Destroy Stream: %@", streamURL);
    [self updateOutput:@""];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:streamURL]];
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

- (IBAction)updateStream:(id)sender {

    if(self.streamID.text.length == 0) {
        [self updateOutput:@"Missing Stream ID"];
        return;
    }

    [self.streamTitle resignFirstResponder];
    [self.searchTerm resignFirstResponder];
    [self.feedIDs resignFirstResponder];
    [self.streamID resignFirstResponder];
    
    NSString* streamURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/update?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    if(self.streamID.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&stream_id=%@", [self encodeText:self.streamID.text]];
    }

    if(self.streamTitle.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&title=%@", [self encodeText:self.streamTitle.text]];
    }
    if(self.searchTerm.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&search_term=%@", [self encodeText:self.searchTerm.text]];
    }
    if(self.feedIDs.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&feed_ids=%@", [self encodeText:self.feedIDs.text]];
    }
    
    streamURL = [streamURL stringByAppendingFormat:@"&only_unread=%@", (self.onlyUnreadSwitch.on ? @"true" : @"false")];
    streamURL = [streamURL stringByAppendingFormat:@"&all_feeds=%@", (self.allFeedsSwitch.on ? @"true" : @"false")];
    NSLog(@"Update Stream: %@", streamURL);
    [self updateOutput:@""];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:streamURL]];
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

- (IBAction)createStream:(id)sender {
    [self.streamTitle resignFirstResponder];
    [self.searchTerm resignFirstResponder];
    [self.feedIDs resignFirstResponder];
    
    NSString* streamURL = [API_URL_PREFIX stringByAppendingFormat:@"streams/create?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    if(self.streamTitle.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&title=%@", [self encodeText:self.streamTitle.text]];
    }
    if(self.searchTerm.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&search_term=%@", [self encodeText:self.searchTerm.text]];
    }
    if(self.feedIDs.text.length > 0) {
        streamURL = [streamURL stringByAppendingFormat:@"&feed_ids=%@", [self encodeText:self.feedIDs.text]];
    }

    streamURL = [streamURL stringByAppendingFormat:@"&only_unread=%@", (self.onlyUnreadSwitch.on ? @"true" : @"false")];
    streamURL = [streamURL stringByAppendingFormat:@"&all_feeds=%@", (self.allFeedsSwitch.on ? @"true" : @"false")];
    NSLog(@"Create Stream: %@", streamURL);
    [self updateOutput:@""];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:streamURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSError* jsonError = nil;
            NSDictionary* response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError != nil) {
                [self updateOutput:[jsonError description]];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.streamID.text = [[[response valueForKey:@"stream"] valueForKey:@"stream_id"] description];
                });
                
                [self updateOutput:[response description]];
            }
        } else {
            [self updateOutput:[error description]];
        }
    }];
    
    
}


@end
