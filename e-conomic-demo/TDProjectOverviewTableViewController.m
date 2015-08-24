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
@interface TDProjectOverviewTableViewController ()

@property (nonatomic, strong) NSArray* intervalArray;

-(void) configureView;
-(void) configureTableView;

@end

@implementation TDProjectOverviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self configureView];
	[self configureTableView];
}

-(void) configureView{
	self.title = self.currentProject.name;
	
	//add right bar button item
	UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
	self.navigationItem.rightBarButtonItem = addButton;
}

-(void) configureTableView{
	self.clearsSelectionOnViewWillAppear = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return cell;
}

#pragma mark - Property accessor overrides

-(void) setCurrentProject:(Project *)currentProject{
	_currentProject = currentProject;
	
	self.intervalArray = [TimeInterval MR_findByAttribute:@"project" withValue:_currentProject andOrderBy:@"startDate" ascending:YES];
	
	NSLog(@"intervalsSorted array = %@", [self.intervalArray description]);
	
	[self.tableView reloadData];
	
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
		
		//instantiate standard nav controller
		UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:newIntervalVC];
		
		[self presentViewController:navController animated:YES completion:^(){}];
	}
}

@end
