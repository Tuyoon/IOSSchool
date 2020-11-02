//
//  DemoModel.h
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 19.10.2020.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Model;
@interface DemoModel : NSObject

@property(nonatomic, strong, readonly) NSString* name;
@property(nonatomic, weak) Model* weakModel;

+ (instancetype)createDemoModel;
+ (instancetype)createDemoModelWithName:(NSString*)name;

@end

@interface DemoModelSubclass : DemoModel

@end

@interface Model : NSObject<NSCopying>

@end
NS_ASSUME_NONNULL_END
