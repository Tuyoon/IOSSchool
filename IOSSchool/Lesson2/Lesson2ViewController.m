//
//  Lesson2ViewController.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 02.11.2020.
//

/*
	Objective-C.
	Жизненный цикл приложения и его события(запуск, активное, бэкграунд, терминейт, нотификации, открытие урл)
	ivar, проперти, модификаторы доступа(strong, weak, copy, assign)
	Категории, протоколы
*/
#import "Lesson2ViewController.h"
#import "DemoModel+Display.h"
#import "NSString+Display.h"
#import "PromoModel.h"

@interface Lesson2ViewController ()

@end

@implementation Lesson2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	DemoModel* demoModel = [DemoModel createDemoModel];
	[demoModel display];
	[demoModel.name display];
	[@"dsasda" display];
	
	id<PromoModelProtocol> promoModel = [self createPromoModel];
	[promoModel methodA];
	[promoModel methodB];
	promoModel.propertyA = @"PROPERTY A";
	
	[self display:promoModel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (id<PromoModelProtocol>)createPromoModel {
	return [PromoModel2 new];
}

-(void)display:(id<PromoModelProtocol>)model {
	NSLog(@"DISPLAY PROTOCOL %@", model.propertyA);
}

@end
