//
//  TDNewIntervalTableViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 23/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDNewIntervalTableViewController.h"
@interface TDNewIntervalTableViewController ()

-(void) configureView;
-(void) configureTableView;

@end

@implementation TDNewIntervalTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self configureView];
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
	
}

#pragma mark - UITableView Delegate methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.row) {
		case 1:
		{
		}
			break;
		case 2:
		{
		}
			break;
			
  default:
			break;
	}
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
