//
//  SecondViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDProjectsOverviewViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Project.h"
#import "TimeInterval.h"
#import "TDProjectSectionHeaderView.h"
@interface TDProjectsOverviewViewController ()
-(void) configureView;
-(void) configureTableView;
-(void) databaseDidChange:(id) sender;
-(void) loadTableViewData;

@property (nonatomic,strong) NSArray* projectOverviewsArray;

@end

@implementation TDProjectsOverviewViewController

-(void) awakeFromNib{
	[super awakeFromNib];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self configureView];
	[self configureTableView];
	[self loadTableViewData];
}

-(void) configureView{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(databaseDidChange:) name:TDDatabaseDidChangeNotification object:nil];
}

-(void) configureTableView{
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"TDProjectSectionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"sectionHeader"];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:TDDatabaseDidChangeNotification object:nil];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
	[selectedCell setSelected:NO animated:YES];
	
	
}

/*
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
	}
}
*/

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	TDProjectSectionHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeader"];
	
	Project* proj = [self.projectOverviewsArray objectAtIndex:section] ;
	
	headerView.labelProjectName.text = proj.name;
	
	
	return headerView;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 30;
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
	
	cell.textLabel.text = [[self.projectOverviewsArray objectAtIndex:indexPath.row] name];

	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return self.projectOverviewsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.projectOverviewsArray.count;
}

-(void) loadTableViewData{
	self.projectOverviewsArray = [Project MR_findAll];
}

-(void) databaseDidChange:(id) sender{
	
	NSNotification * notif = (NSNotification*) sender;
	
	if ([notif.userInfo[@"deleted"] boolValue]) {
		
	}else{
		[self loadTableViewData];
		[self.tableView reloadData];
	}
	
}


@end
