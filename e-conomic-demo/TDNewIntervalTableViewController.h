//
//  TDNewIntervalTableViewController.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 23/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDNewIntervalTableViewController : UITableViewController<UITextFieldDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (weak, nonatomic) IBOutlet UILabel *labelStartDate;
@property (weak, nonatomic) IBOutlet UILabel *labelEndDate;

@end
