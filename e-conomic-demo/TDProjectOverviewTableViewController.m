//
//  TDProjectOverviewTableViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDProjectOverviewTableViewController.h"
#import "TDIntervalTableViewCell.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <MagicalRecord/MagicalRecord.h>
#import "TimeInterval.h"
#import "TDNewIntervalTableViewController.h"
#import "TDTimeIntervalValidator.h"
#import "TDCoreDataManager.h"
@interface TDProjectOverviewTableViewController ()

@property (nonatomic, strong) NSArray* intervalArray;
@property (nonatomic, strong) NSDateFormatter * dateFormatter;
@property (nonatomic, strong) NSDateFormatter * timeFormatter;

-(void) configureView;
-(void) configureTableView;
-(void) loadTableViewData;
-(void) configureDateAndTimeFormatter;

@end

@implementation TDProjectOverviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self configureView];
	[self configureTableView];
	[self configureDateAndTimeFormatter];
}

-(void) configureView{
	self.title = self.currentProject.name;
	
	//add right bar button item
	UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(databaseDidChange:) name:TDDatabaseDidChangeNotification object:nil];
}

-(void) configureTableView{
	self.clearsSelectionOnViewWillAppear = NO;
}

-(void) configureDateAndTimeFormatter{
	//set up date formatter
	self.dateFormatter = [[NSDateFormatter alloc] init];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[self.dateFormatter setLocale:[NSLocale currentLocale]];
	
	//set up time formatter
	self.timeFormatter =[[NSDateFormatter alloc] init];
	[self.timeFormatter setDateStyle:NSDateFormatterNoStyle];
	[self.timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	[self.dateFormatter setLocale:[NSLocale currentLocale]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:TDDatabaseDidChangeNotification object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [self.intervalArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDIntervalTableViewCell *cell = (TDIntervalTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"intervalCell" forIndexPath:indexPath];
    
    // Configure the cell...
	TimeInterval * ti = [self.intervalArray objectAtIndex:indexPath.row];
	
	if ([[NSCalendar currentCalendar] isDate:ti.startDate inSameDayAsDate:ti.endDate]) {
		//if it's in the same day
		cell.labelIntervalDate.text = [self.dateFormatter stringFromDate:ti.startDate];
	}else{
		cell.labelIntervalDate.text =[ NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:ti.startDate],[self.dateFormatter stringFromDate:ti.endDate]];
	}
	
	cell.labelStartHour.text = [self.timeFormatter stringFromDate:ti.startDate];
	cell.labelEndHour.text = [self.timeFormatter stringFromDate:ti.endDate];
	cell.labelTaskName.text = ti.title;
	
    
    return cell;
}

#pragma mark - Property accessor overrides

-(void) setCurrentProject:(Project *)currentProject{
	_currentProject = currentProject;
	
	[self loadTableViewData];
	[self.tableView reloadData];

}

-(void) loadTableViewData{
	self.intervalArray = [TimeInterval MR_findByAttribute:@"project" withValue:_currentProject andOrderBy:@"startDate" ascending:YES];
	
	NSLog(@"intervalsSorted array = %@", [self.intervalArray description]);
	
	
}

#pragma mark - Actions

-(void) addButtonPressed:(id) sender{
	DDLogInfo(@"Add button pressed!");
	
	[self performSegueWithIdentifier:@"showAddNewIntervalVC" sender:self.currentProject];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
	if ([identifier isEqualToString:@"showAddNewIntervalVC"]) {

		//instantiate NewIntervalVC
		TDNewIntervalTableViewController * newIntervalVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"newIntervalTableVC"];
		newIntervalVC.delegate =self;
		
		//instantiate standard nav controller
		UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:newIntervalVC];
		
		[self presentViewController:navController animated:YES completion:^(){}];
	}
}

#pragma mark - TDNewIntervalTableViewController.h methods

-(void) newIntervalTableViewControllerdidCancel:(TDNewIntervalTableViewController *)intervalTableViewController{

	DDLogInfo(@"new interval creation cancelled");
}

-(void) newIntervalTableViewControllerDidSave:(TDNewIntervalTableViewController *)intervalTableViewController taskName:(NSString *)taskName withStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
	//TODO: Perform date validation before accepting
	TDTimeIntervalAssertion validation = [TDTimeIntervalValidator validateTimeIntervalWithStartDate:startDate endDate:endDate	forProject:self.currentProject];
	
	if (validation == TDTimeIntervalAssertionValid) {
		DDLogInfo(@"Time interval accepted. Saving to database.");
		[[TDCoreDataManager sharedInstance] addTimeIntervalToProject:self.currentProject withTitle:taskName startDate:startDate andEndDate:endDate];
		
	}else{
		DDLogInfo(@"Time interval invalid. Not saving.");
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Time interval is invalid" message:@"The time interval you selected is invalid. Please check that the interval is not included in other time intervals already saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}

}

#pragma mark - Database changed

-(void) databaseDidChange:(id) sender{
	
	[self loadTableViewData];
	[self.tableView reloadData];

}

@end
