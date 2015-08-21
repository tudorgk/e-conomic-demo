//
//  TDNewProjectModalViewController.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDNewProjectModalViewController.h"
#import "TDCoreDataManager.h"
#import "NSString+StringValidation.h"
@interface TDNewProjectModalViewController ()

@end

@implementation TDNewProjectModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveButtonTapped:(id)sender {
	
	if ([self.textfieldProjectName.text validateAlphanumericSpace] && [self.textfieldProjectName.text validateNotEmpty]) {
		
		//TODO: Quick testing
		[[TDCoreDataManager sharedInstance] addNewProjectToDatabaseWithName:self.textfieldProjectName.text andDetails:[[NSDate date] description]];
		[self dismissViewControllerAnimated:YES completion:nil];
	}else{
		self.labelWarning.hidden = NO;
	}

}


- (IBAction)cancelButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
