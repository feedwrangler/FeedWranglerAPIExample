//
//  CFCUsersViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCUsersLoginViewController.h"

@interface CFCUsersLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation CFCUsersLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)loginPressed:(id)sender {
    
    [self.password resignFirstResponder];
    [self.emailAddress resignFirstResponder];
    
    NSString* loginURL = [API_URL_PREFIX stringByAppendingFormat:@"users/authorize?email=%@&password=%@&client_key=%@", [self encodeText:self.emailAddress.text], [self encodeText:self.password.text], CLIENT_ID];
    NSLog(@"LOGIN: %@", loginURL);
    [self updateOutput:@""];

    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if ([data length] > 0 && error == nil) {
            NSError* jsonError = nil;
            NSDictionary* response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            NSLog(@"%@", response);
            if(jsonError != nil) {
                [self updateOutput:[jsonError description]];
            } else {
                NSString* token = [response valueForKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                [self updateOutput:[response description]];
            }
        } else {
            [self updateOutput:[error description]];
        }
    }];
}

@end
