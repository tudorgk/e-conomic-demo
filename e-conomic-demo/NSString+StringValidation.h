//
//  NSString+StringValidation.h
//
//  Created by Tudor Dragan on 11/3/14.
//  Copyright (c) 2014 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringValidation)

- (BOOL)validateNotEmpty;
- (BOOL)validateMinimumLength:(NSInteger)length;
- (BOOL)validateMaximumLength:(NSInteger)length;
- (BOOL)validateMatchesConfirmation:(NSString *)confirmation;
- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet;
- (BOOL)validateAlpha;
- (BOOL)validateAlphanumeric;
- (BOOL)validateNumeric;
- (BOOL)validateAlphaSpace;
- (BOOL)validateAlphanumericSpace;
- (BOOL)validateUsername;
- (BOOL)validateEmail:(BOOL)stricterFilter;
- (BOOL)validatePhoneNumber;

@end
