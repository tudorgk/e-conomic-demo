//
//  FirstViewController.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDProjectListViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItemAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItemEdit;

@end

