//
//  TDNewIntervalTableViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 23/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDNewIntervalTableViewController.h"
#import <RMDateSelectionViewController/RMDateSelectionViewController.h>
#import "TDTimeUtils.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
@interface TDNewIntervalTableViewController ()

@property (nonatomic,strong) UIDatePicker * startDatePicker;
@property (nonatomic,strong) UIDatePicker * endDatePicker;

@property (nonatomic,strong) NSDate *selectedStartDate;
@property (nonatomic,strong) NSDate *selectedEndDate;

-(void) configureView;
-(void) configureTableView;
-(void) configureDatePickers;

@end

@implementation TDNewIntervalTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self configureView];
	[self configureTableView];
	[self configureDatePickers];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void) configureView{
	//set title
	self.title = @"Add New Interval";
	
	//add cancel button
	UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	
	//add save button
	UIBarButtonItem * saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
	self.navigationItem.rightBarButtonItem = saveButton;
}

-(void) configureTableView{
	self.textFieldTaskName.delegate = self;
	
	//instantiate and configure date pickers
	self.startDatePicker = [[UIDatePicker alloc] init];
}



#pragma mark - UITableView Delegate methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 1:
		{
			[self openDateSelectionController:indexPath];
		}
			break;
		case 2:
		{
			[self openDateSelectionController:indexPath];
		}
			break;
			
  default:
			break;
	}
}


#pragma mark - Date Selection Methods

-(void) configureDatePickers{
	self.selectedStartDate = [TDTimeUtils dateToNearest15MinutesForDate:[NSDate date]];
	
	DDLogDebug(@"selected Start Date = %@", self.selectedStartDate);
	
	self.selectedEndDate = [self.selectedStartDate dateByAddingTimeInterval:(15*60)];
}


- (IBAction)openDateSelectionController:(id)sender {
	
	//if start date or end date selected
	NSIndexPath * selectedIndexPath = (NSIndexPath*) sender;
	
	if (selectedIndexPath.row == 1) {
		//Create select action
		RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
			
			NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
		}];
		
		//Create cancel action
		RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
			NSLog(@"Date selection was canceled");
		}];
		
		//Create date selection view controller
		RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleBlack selectAction:selectAction andCancelAction:cancelAction];

		
		//start date
		dateSelectionController.title = @"Select start date";

		dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
		dateSelectionController.datePicker.minuteInterval = 15;
		dateSelectionController.datePicker.date = self.selectedStartDate;
		
		DDLogDebug(@"date picker Start Date = %@", dateSelectionController.datePicker.date);

		[self presentViewController:dateSelectionController animated:YES completion:nil];
	}
	
	
	
}



 #pragma mark - Navigation

-(void) cancelButtonPressed:(id) sender{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveButtonPressed: (id) sender{
	
}

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
	
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
	
}



@end
