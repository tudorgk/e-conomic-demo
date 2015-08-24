//
//  TDNewIntervalTableViewController.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 23/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TDNewIntervalTableViewController;

@protocol TDNewIntervalTableViewControllerDelegate <NSObject>
@optional
-(void) newIntervalTableViewControllerDidSave:(TDNewIntervalTableViewController*) intervalTableViewController
									 taskName:(NSString*) taskName
								withStartDate:(NSDate*)startDate
								   andEndDate:(NSDate*) endDate;
-(void) newIntervalTableViewControllerdidCancel:(TDNewIntervalTableViewController *)intervalTableViewController;

@end

@interface TDNewIntervalTableViewController : UITableViewController<UITextFieldDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTaskName;
@property (weak, nonatomic) IBOutlet UILabel *labelStartDate;
@property (weak, nonatomic) IBOutlet UILabel *labelEndDate;

@property (nonatomic,assign) id<TDNewIntervalTableViewControllerDelegate> delegate;

@end
