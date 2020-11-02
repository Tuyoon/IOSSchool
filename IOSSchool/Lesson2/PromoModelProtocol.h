//
//  PromoModelProtocol.h
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 19.10.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PromoModelProtocol <NSObject>

@property(nonatomic, strong) NSString* propertyA;

- (void)methodA;
- (void)methodB;

@end

NS_ASSUME_NONNULL_END
