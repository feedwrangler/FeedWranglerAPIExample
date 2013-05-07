//
//  CFCUsersLogoutViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCUsersLogoutViewController.h"

@interface CFCUsersLogoutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentToken;
@end

@implementation CFCUsersLogoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.currentToken.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

- (IBAction)logout:(id)sender {
        
    NSString* logoutURL = [API_URL_PREFIX stringByAppendingFormat:@"users/logout?access_token=%@&client_key=%@", self.currentToken.text, CLIENT_ID];
    NSLog(@"LOGOUT: %@", logoutURL);
    
    [self updateOutput:@""];

    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:logoutURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSError* jsonError = nil;
            NSDictionary* response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError != nil) {
                [self updateOutput:[jsonError description]];
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
                [self updateOutput:[response description]];
            }
        } else {
            [self updateOutput:[error description]];
        }
    }];
}

@end
