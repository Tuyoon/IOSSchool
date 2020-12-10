//
//  Lesson7ObjcClasses.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 10.12.2020.
//

#import "Lesson7ObjcClasses.h"

@protocol L7ObjcProtocol <NSObject>

//@required можно не писать, по умолчанию все методы в протоколе @required
-(void)printName;
-(void)printLastName;

// все методы идущие после @optional будут опциональными т.е. могут быть не реализованы
@optional
- (void)printName:(NSString*)name lastName:(NSString*)lastName;
- (void)printLastName:(NSString*)lastName;

@end

@interface L7ObjcClassA : NSObject<L7ObjcProtocol>
@end

@implementation L7ObjcClassA

- (void)printLastName {
	NSLog(@"This is last name A");
}

- (void)printName {
	NSLog(@"This is name A");
}

@end

#pragma mark -

@interface L7ObjcClassB : NSObject

@end

@implementation L7ObjcClassB

- (instancetype)init {
	self = [super init];
	if (self) {
		
		// id<L7ObjcProtocol> это тип объекта, который реализует протокол L7ObjcProtocol
		// id - это любой тип(reference)
		id<L7ObjcProtocol> object = [L7ObjcClassA new];
		// проверяем реализует ли объект протокол L7ObjcProtocol
		if ([object conformsToProtocol:@protocol(L7ObjcProtocol)]) {
			SEL selector = @selector(printName:lastName:);
			// respondsToSelector - проверяет наличие метода (обычно для опциональных методов)
			if ([object respondsToSelector:selector]) {
				// чтобы не было ошибки unrecognize selector send to instance
				[object printName:@"name" lastName:@"last name"];
			}
		}
	}
	return self;
}

@end
