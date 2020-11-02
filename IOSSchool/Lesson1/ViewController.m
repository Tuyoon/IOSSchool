//
//  ViewController.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 12.10.2020.
//

/*
	Objective-C. Обзор Xcode: проект, настройки, интерфейс.
	Синтаксис, вызов методов, обмен сообщениями.
	Классы
*/

#import "ViewController.h"
#import "PhoneCaller.h"
#import "DemoModel.h"
#import <objc/runtime.h>

@interface ViewController () {
	DemoModel* _model;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self checkModel];
}

- (void)checkModel {
	NSString* someString = @"asdsad";
	someString = @"12";
	
	id someId = @"adsdas";
	someId = @132;
	someId = @YES;
	
	[PhoneCaller someClassMethod];
	PhoneCaller* caller = [[PhoneCaller alloc] initWithProvider:@"pasd"];
	caller = [PhoneCaller phoneCallerWithProvider:@"sadasa"];
	[caller callToPhoneNumber:@"123123123" withAdditionalNumber:@"11" withMessage:@"Hello"];
	[caller callToPhoneNumber:@"123123123" withAdditionalNumber:@"11"];
	
//	id returnValue = objc_msgSend(self, @selector(callToPhoneNumber:withAdditionalNumber:withMessage:), @"123", @"11", "Hello");
	// Do any additional setup after loading the view.
}
@end
