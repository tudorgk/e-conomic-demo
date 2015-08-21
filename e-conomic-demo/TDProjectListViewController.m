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
@interface TDProjectListViewController ()

@property (nonatomic,strong) NSArray* projectArray;

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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(databaseDidChange) name:TDDatabaseDidChangeNotification object:nil];
	
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
	self.projectArray = [Project MR_findAll];
}

-(void) databaseDidChange{
	[self loadTableViewData];
	[self.tableView reloadData];
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

@end
