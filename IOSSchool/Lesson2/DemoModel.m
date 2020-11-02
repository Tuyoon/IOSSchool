//
//  DemoModel.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 19.10.2020.
//

#import "DemoModel.h"

@interface DemoModel ()

@property(nonatomic, strong, readwrite) NSString* name;
- (void)doSomething;

@end


@implementation DemoModel {
	NSString* _localName;
}

+ (instancetype)createDemoModel {
	DemoModel* model = [DemoModel new];
	return model;
}

+ (instancetype)createDemoModelWithName:(NSString *)name {
	DemoModel* model = [[DemoModel alloc] initWithName:name];
	return model;
}

- (instancetype)init {
	return [self initWithName:@"Demo model name"];
}

- (instancetype)initWithName:(NSString*)name {
	self = [super init];
	if (self) {
		_localName = name;
		[self doSomething];
	}
	return self;
}

- (void)doSomething {
	self.name = @"New name";
}

- (void)setName:(NSString *)name {
	_name = name;
	NSLog(@"NEW Demo Model name: %@", _name);
}

- (id)copyWithZone:(nullable NSZone *)zone {
	DemoModel* model = [DemoModel new];
	model.name = self.name;
	model.weakModel = self.weakModel;
	return model;
}

@end

@implementation DemoModelSubclass

+ (DemoModel*)createDemoModel {
	DemoModelSubclass* model = [DemoModelSubclass new];
	return model;
}

@end

@implementation Model

- (id)copyWithZone:(nullable NSZone *)zone {
	return [Model new];
}

@end
