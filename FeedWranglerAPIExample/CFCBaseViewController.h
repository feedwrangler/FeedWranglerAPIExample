//
//  CFCBaseViewController.h
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFCBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *output;

- (NSString *)encodeText:(NSString *)text;
-(void)updateOutput:(NSString*)message;
@end
