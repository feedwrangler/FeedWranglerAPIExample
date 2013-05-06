//
//  CFCMasterViewController.h
//  FeedWranglerAPIExample
//
//  Created by David Smith on 5/6/13.
//  Copyright (c) 2013 Developing Perspective, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFCDetailViewController;

@interface CFCMasterViewController : UITableViewController

@property (strong, nonatomic) CFCDetailViewController *detailViewController;

@end
