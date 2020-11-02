//
//  PromoModel.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 19.10.2020.
//

#import "PromoModel.h"

@interface PromoModel () <PromoModelProtocol>

@end

@implementation PromoModel

@synthesize propertyA = _propertyA;

- (void)methodA {
	NSLog(@"METHOD A");
}

- (void)methodB {
	NSLog(@"METHOD B");
}

- (void)setPropertyA:(NSString *)propertyA {
	_propertyA = propertyA;
	NSLog(@"PROPERTY NAME: %@", _propertyA);
}

@end

@implementation PromoModel2

@synthesize propertyA = _propertyA;

- (void)methodA {
	NSLog(@"METHOD 2A");
}

- (void)methodB {
	NSLog(@"METHOD 2B");
}

- (void)setPropertyA:(NSString *)propertyA {
	_propertyA = propertyA;
	NSLog(@"PROPERTY NAME 2: %@", _propertyA);
}
@end
