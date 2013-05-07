//
//  CFCBaseViewController.m
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import "CFCBaseViewController.h"

@interface CFCBaseViewController ()

@end

@implementation CFCBaseViewController

- (NSString *)encodeText:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    
    CFStringRef ref = CFURLCreateStringByAddingPercentEscapes( NULL,
                                                              (CFStringRef)text,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8 );
    
    NSString *encoded = [NSString stringWithString: (__bridge NSString *)ref];
    
    CFRelease( ref );
    
    return encoded;
}

-(void)updateOutput:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.output.text = message;
    });
}

@end
