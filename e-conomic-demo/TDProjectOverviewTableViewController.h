//
//  TDProjectOverviewTableViewController.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "TDNewIntervalTableViewController.h"
@interface TDProjectOverviewTableViewController : UITableViewController <TDNewIntervalTableViewControllerDelegate>
@property (nonatomic,strong) Project * currentProject;
@end
