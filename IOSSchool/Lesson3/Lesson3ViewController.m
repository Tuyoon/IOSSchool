//
//  Lesson3ViewController.m
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 02.11.2020.
//

/*
 Замыкания(блоки): синтаксис, область захвата, _weak, inline, 
 GCD: sync, async, semaphore, group, barrier
 */

#import "Lesson3ViewController.h"

@interface Lesson3ViewController () {
	__weak int(^weakaddBlock)(int, int);
}

@property(nonatomic, strong) int(^addBlock)(int, int);
@property(nonatomic, weak) IBOutlet UIImageView* imageView;

@end

@implementation Lesson3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	int(^addBlock)(int, int) = ^(int a, int b) {
		return a + b;
	};
	int c = addBlock(1, 2);
	int d = addBlock(addBlock(1,3), 3);

	self.addBlock = addBlock;
	self.addBlock = ^int(int a, int b) {
		return a + b;
	};
}

- (void)configure:(int(^)(int, int))addBlock {
	self.addBlock = addBlock;
}

- (IBAction)loadButtonPressed:(id)sender {
	[self loadFromUrl:@"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010?wid=3012&hei=1582&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1601496902000" completion:^(UIImage *image) {
		self.imageView.image = image;
	}];
	[self gcdGroups];
}

- (void)loadFromUrl:(NSString*)urlString completion:(void(^)(UIImage*))completion {
	NSURL* url = [NSURL URLWithString:urlString];
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
//	__weak ViewController* weakSelf = self;
	NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if(error) {
			NSLog(@"LOAD error %@, %@", error.localizedDescription, url.absoluteString);
		} else {
			completion([UIImage imageWithData:data]);
		}
	}];
	[task resume];
}

- (void)gcdSemaphore {
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block UIImage* image;
	[self loadFromUrl:@"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010?wid=3012&hei=1582&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1601496902000" completion:^(UIImage *img) {
		image = img;
		dispatch_semaphore_signal(semaphore);
	}];
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
	self.imageView.image = image;

}

- (void)gcdGroups {
	NSArray* urls = @[
		@"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010?wid=3012&hei=1582&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1601496902000",
		@"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010?wid=3012&hei=1582",
		@"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-trade-in-202010",
	];
	
	dispatch_group_t group = dispatch_group_create();
	
	__block NSMutableArray* images = [NSMutableArray new];
	for (NSString* url in urls) {
		dispatch_group_enter(group);
		[self loadFromUrl:url completion:^(UIImage *img) {
			[images addObject:img];
			dispatch_group_leave(group);
		}];
	}
	
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	self.imageView.image = images.lastObject;
}

- (void)gcdBarrier {
	dispatch_barrier_sync(dispatch_get_main_queue(), ^{
		
	});
	dispatch_barrier_async(dispatch_get_main_queue(), ^{
		
	});
}

@end

@interface SafeModel: NSObject

@property (nonatomic, strong) NSString* modelName;

@end

@implementation SafeModel {
	dispatch_queue_t _queue;
}

@synthesize modelName = _modelName;

- (instancetype)init {
	self = [super init];
	if(self) {
		_queue = dispatch_queue_create(@"com.aaa.bbb".UTF8String, nil);
	}
	return self;
}

- (void)setModelName:(NSString *)modelName {
	dispatch_barrier_sync(_queue, ^{
		_modelName = modelName;
	});
}

- (NSString *)modelName {
	__block NSString* name;
	dispatch_sync(_queue, ^{
		name = _modelName;
	});
	return name;
}

@end
