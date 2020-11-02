//
//  PhoneCaller.h
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 12.10.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneCaller : NSObject

+ (void)someClassMethod;
+ (instancetype)phoneCallerWithProvider:(NSString*)provider;
- (instancetype)initWithProvider:(NSString*)provider;
- (void)callToPhoneNumber:(NSString*)phoneNumber withAdditionalNumber:(NSString*)additionalNumber;
- (void)callToPhoneNumber:(NSString*)phoneNumber withAdditionalNumber:(NSString*)additionalNumber withMessage:(NSString*)message;

@end

NS_ASSUME_NONNULL_END
