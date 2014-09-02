//
//  AJViewController.h
//  World Traveler
//
//  Created by Allan Jones on 8/19/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
