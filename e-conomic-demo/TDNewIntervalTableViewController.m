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
#import "TDTimeIntervalValidator.h"
@interface TDNewIntervalTableViewController ()

@property (nonatomic,strong) NSDate *selectedStartDate;
@property (nonatomic,strong) NSDate *selectedEndDate;

@property (nonatomic,strong) NSDateFormatter * dateFormatter;

-(void) configureView;
-(void) configureTableView;
-(void) configureDatePickers;

@end

@implementation TDNewIntervalTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self configureView];
	[self configureDatePickers];
	[self configureTableView];

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
	
	self.labelStartDate.text = [self.dateFormatter stringFromDate:self.selectedStartDate];
	self.labelEndDate.text = [self.dateFormatter stringFromDate:self.selectedEndDate];
}



#pragma mark - UITableView Delegate methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
	[cell setSelected:NO animated:YES];
	
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
	
	//set up initial dates
	self.selectedStartDate = [TDTimeUtils dateToNearest15MinutesForDate:[NSDate date]];
	DDLogDebug(@"selected Start Date = %@", self.selectedStartDate);
	self.selectedEndDate = [self.selectedStartDate dateByAddingTimeInterval:(30*60)];
	
	//set up date formatter
	self.dateFormatter = [[NSDateFormatter alloc] init];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[self.dateFormatter setLocale:[NSLocale currentLocale]];
	
}


- (IBAction)openDateSelectionController:(id)sender {
	
	//if start date or end date selected
	NSIndexPath * selectedIndexPath = (NSIndexPath*) sender;
	
	// Create a weak reference
	__weak TDNewIntervalTableViewController *weakSelf = self;
	
	if (selectedIndexPath.row == 1) {
		//Create select action
		RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
			
			NSDate * selectedDate = ((UIDatePicker *)controller.contentView).date;
			NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
			
			//set current selected date
			weakSelf.selectedStartDate = selectedDate;
			
			//refresh the label
			weakSelf.labelStartDate.text = [weakSelf.dateFormatter stringFromDate:weakSelf.selectedStartDate];
		}];
		
		//Create cancel action
		RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
			NSLog(@"Date selection was canceled");
		}];
		
		//Create date selection view controller
		RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleBlack selectAction:selectAction andCancelAction:cancelAction];

		
		//start date
		dateSelectionController.title = @"Select start time";

		dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
		dateSelectionController.datePicker.minuteInterval = 15;
		dateSelectionController.datePicker.date = self.selectedStartDate;
		dateSelectionController.datePicker.maximumDate = [self.selectedEndDate dateByAddingTimeInterval:(-15*60)];
		
		DDLogDebug(@"date picker Start Date = %@", dateSelectionController.datePicker.date);

		[self presentViewController:dateSelectionController animated:YES completion:nil];
	}else{
		
		// Create a weak reference
		__weak TDNewIntervalTableViewController *weakSelf = self;
		
		//Create select action
		RMAction *selectAction = [RMAction actionWithTitle:@"Select" style:RMActionStyleDone andHandler:^(RMActionController *controller) {
			NSDate * selectedDate = ((UIDatePicker *)controller.contentView).date;
			NSLog(@"Successfully selected date: %@", ((UIDatePicker *)controller.contentView).date);
			
			//set current selected date
			weakSelf.selectedEndDate = selectedDate;
			
			//refresh the label
			weakSelf.labelEndDate.text = [weakSelf.dateFormatter stringFromDate:weakSelf.selectedEndDate];
		}];
		
		//Create cancel action
		RMAction *cancelAction = [RMAction actionWithTitle:@"Cancel" style:RMActionStyleCancel andHandler:^(RMActionController *controller) {
			NSLog(@"Date selection was canceled");
		}];
		
		//Create date selection view controller
		RMDateSelectionViewController *dateSelectionController = [RMDateSelectionViewController actionControllerWithStyle:RMActionControllerStyleBlack selectAction:selectAction andCancelAction:cancelAction];
		
		
		//start date
		dateSelectionController.title = @"Select end time";
		
		dateSelectionController.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
		dateSelectionController.datePicker.minuteInterval = 15;
		dateSelectionController.datePicker.date = self.selectedEndDate;
		dateSelectionController.datePicker.minimumDate = [self.selectedStartDate dateByAddingTimeInterval:(15*60)];
		
		DDLogDebug(@"date picker Start Date = %@", dateSelectionController.datePicker.date);
		
		[self presentViewController:dateSelectionController animated:YES completion:nil];

	}

}

#pragma mark - Navigation

-(void) cancelButtonPressed:(id) sender{
	if (self.delegate != nil && [self.delegate respondsToSelector:@selector(newIntervalTableViewControllerdidCancel:)]) {
		[self.delegate newIntervalTableViewControllerdidCancel:self];
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveButtonPressed: (id) sender{
	
	if (self.delegate != nil && [self.delegate respondsToSelector:@selector(newIntervalTableViewControllerDidSave:taskName:withStartDate:andEndDate:)]) {
		[self.delegate newIntervalTableViewControllerDidSave:self taskName:self.textFieldTaskName.text withStartDate:self.selectedStartDate andEndDate:self.selectedEndDate];
	}
	[self dismissViewControllerAnimated:YES completion:nil];
	
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
