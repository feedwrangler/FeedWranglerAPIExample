//
//  CFCFeedItemsSearchViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCFeedItemsSearchViewController.h"

@interface CFCFeedItemsSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTerm;
@property (weak, nonatomic) IBOutlet UITextField *limitFilter;
@property (weak, nonatomic) IBOutlet UITextField *offsetFilter;

@end

@implementation CFCFeedItemsSearchViewController

- (IBAction)performSearch:(id)sender {

    [self.limitFilter resignFirstResponder];
    [self.offsetFilter resignFirstResponder];
    [self.searchTerm resignFirstResponder];
    
    NSString* searchURL = [API_URL_PREFIX stringByAppendingFormat:@"feed_items/search?access_token=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
        //Limit number of results
    if(self.limitFilter.text.length > 0) {
        searchURL = [searchURL stringByAppendingFormat:@"&limit=%@", self.limitFilter.text];
    }
    
        //Page Offset
    if(self.offsetFilter.text.length > 0) {
        searchURL = [searchURL stringByAppendingFormat:@"&offset=%@", self.offsetFilter.text];
    }
    
    searchURL = [searchURL stringByAppendingFormat:@"&search_term=%@", [self encodeText:self.searchTerm.text]];
    
    NSLog(@"Search: %@", searchURL);
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:searchURL]];
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
