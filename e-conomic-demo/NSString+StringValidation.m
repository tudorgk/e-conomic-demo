//
//  NSString+StringValidation.m
//
//  Created by Tudor Dragan on 11/3/14.
//  Copyright (c) 2014 tudordev.com. All rights reserved.
//

#import "NSString+StringValidation.h"

@implementation NSString (StringValidation)

- (BOOL)validateNotEmpty
{
	return ([self length] != 0);
}

- (BOOL)validateMinimumLength:(NSInteger)length
{
	return ([self length] >= length);
}

- (BOOL)validateMaximumLength:(NSInteger)length
{
	return ([self length] <= length);
}

- (BOOL)validateMatchesConfirmation:(NSString *)confirmation
{
	return [self isEqualToString:confirmation];
}


- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet
{
	return ([self rangeOfCharacterFromSet:[characterSet invertedSet]].location == NSNotFound);
}


- (BOOL)validateAlpha
{
	return [self validateInCharacterSet:[NSMutableCharacterSet letterCharacterSet]];
}

- (BOOL)validateAlphanumeric
{
	return [self validateInCharacterSet:[NSMutableCharacterSet alphanumericCharacterSet]];
}

- (BOOL)validateNumeric
{
	return [self validateInCharacterSet:[NSMutableCharacterSet decimalDigitCharacterSet]];
}

- (BOOL)validateAlphaSpace
{
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet letterCharacterSet];
	[characterSet addCharactersInString:@" "];
	return [self validateInCharacterSet:characterSet];
}

- (BOOL)validateAlphanumericSpace
{
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
	[characterSet addCharactersInString:@" "];
	return [self validateInCharacterSet:characterSet];
}

- (BOOL)validateUsername
{
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
	[characterSet addCharactersInString:@"'_."];
	return [self validateInCharacterSet:characterSet];
}

- (BOOL)validateEmail:(BOOL)stricterFilter
{
	NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:self];
}

- (BOOL)validatePhoneNumber
{
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
	[characterSet addCharactersInString:@"'-*+#,;. "];
	return [self validateInCharacterSet:characterSet];
}

@end