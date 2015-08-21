//
//  FirstViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDProjectListViewController.h"

@interface TDProjectListViewController ()
-(void) configureView;
-(void) configureTableView;
@end

@implementation TDProjectListViewController

-(void) awakeFromNib{
	[super awakeFromNib];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self configureView];
	[self configureTableView];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
#pragma mark - Configure methods

-(void) configureView{
	
}

-(void) configureTableView{
	
	//setting the delegate
	self.tableView.delegate = self;
	self.tableView.dataSource = self;

}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
	
	cell.textLabel.text = @"Testing";
	cell.detailTextLabel.text = @"DetailLabel";
	
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 20;
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
