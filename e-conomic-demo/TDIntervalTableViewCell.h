//
//  TDIntervalTableViewCell.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDIntervalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelStartHour;
@property (weak, nonatomic) IBOutlet UILabel *labelEndHour;
@property (weak, nonatomic) IBOutlet UILabel *labelTaskName;
@property (weak, nonatomic) IBOutlet UILabel *labelIntervalDate;

-(void) configureIntevalCellWithTaskName:(NSString*) taskName
							   startDate:(NSDate*) startDate
								 endDate:(NSDate*) endDate;

@end
