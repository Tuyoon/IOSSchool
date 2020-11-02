//
//  StringProtocol.h
//  IOSSchool
//
//  Created by Arkadiy Tsoy on 21.10.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StringProtocol <NSObject>

// Проверить является ли строка пустой
@property (nonatomic, assign) BOOL isEmpty;

// Вывести в консоль с строку соединенную с другой строкой
- (NSString*)printJoinedWith:(NSString*)otherString;

@end

NS_ASSUME_NONNULL_END
