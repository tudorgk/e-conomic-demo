//
//  FirstViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDProjectListViewController.h"
#import "Project.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TDCoreDataManager.h"
#import "TDProjectOverviewTableViewController.h"
@interface TDProjectListViewController ()

@property (nonatomic,strong) NSMutableArray* projectArray;

-(void) configureView;
-(void) configureTableView;

-(void) loadTableViewData;

@end


@implementation TDProjectListViewController

-(void) awakeFromNib{
	[super awakeFromNib];

}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self configureView];
	[self configureTableView];
	
	[self loadTableViewData];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:TDDatabaseDidChangeNotification object:nil];
}
#pragma mark - Configure methods

-(void) configureView{
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(databaseDidChange:) name:TDDatabaseDidChangeNotification object:nil];
	
}

-(void) configureTableView{
	
	//setting the delegate
	self.tableView.delegate = self;
	self.tableView.dataSource = self;

}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[selectedCell setSelected:NO animated:YES];
	
	//push on navigation controller the project overview view controller
	[self performSegueWithIdentifier:@"pushProjectOverview" sender:[self.projectArray objectAtIndex:indexPath.row]];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		Project * projectToDelete = [self.projectArray objectAtIndex:indexPath.row];
		[self.projectArray removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
		[[TDCoreDataManager sharedInstance] removeProjectFromDatabase:projectToDelete];
		
	}
}
#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
	
	Project * project = [self.projectArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = project.name;
	cell.detailTextLabel.text = project.details;
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.projectArray.count;
}

-(void) loadTableViewData{
	self.projectArray = [NSMutableArray arrayWithArray:[Project MR_findAll]];
}

-(void) databaseDidChange:(id) sender{
	
	NSNotification * notif = (NSNotification*) sender;
	
	if ([notif.userInfo[@"deleted"] boolValue]) {
		
	}else{
		[self loadTableViewData];
		[self.tableView reloadData];
	}
	
}


#pragma mark - Action methods
- (IBAction)addButtonTapped:(id)sender {
	//Instatiate new project navigation controller
	UINavigationController * newProjNavController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"newProjectNavigationController"];
	
	//present it
	[self presentViewController:newProjNavController animated:YES completion:^(){
	}];
}


- (IBAction)editButtonTapped:(id)sender {
}


 #pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
	
}

-(void) performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
	if ([identifier isEqualToString:@"pushProjectOverview"]) {
		//instantiate Project OVerview VC
		TDProjectOverviewTableViewController * projectOverviewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"projectOverview"];
		Project *selectedProject = (Project*) sender;
		projectOverviewVC.currentProject = selectedProject;
		[self.navigationController pushViewController:projectOverviewVC animated:YES];
	}
}


@end
