//
//  PhoneCaller.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 12.10.2020.
//

#import "PhoneCaller.h"

@implementation PhoneCaller {
	NSString* _provider;
}

+ (void)someClassMethod {
	
}

+ (instancetype)phoneCallerWithProvider:(NSString *)provider
{
	PhoneCaller* phoneCaller = [[PhoneCaller alloc] initWithProvider:provider];
	return phoneCaller;
}

- (instancetype)initWithProvider:(NSString*)provider
{
	self = [super init];
	if(self != nil) {
		_provider = provider;
	}
	return self;
}

- (void)callToPhoneNumber:(NSString*)phoneNumber withAdditionalNumber:(NSString*)additionalNumber
{
	[self callToPhoneNumber:phoneNumber withAdditionalNumber:additionalNumber withMessage:@"default message"];
}

- (void)callToPhoneNumber:(NSString*)phoneNumber withAdditionalNumber:(NSString*)additionalNumber withMessage:(NSString*)message
{
	NSLog(@"CALLING: %@", phoneNumber);
}

@end
