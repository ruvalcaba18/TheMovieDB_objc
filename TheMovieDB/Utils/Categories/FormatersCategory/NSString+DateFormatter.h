//
//  NSString+DateFormatter.h
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DateFormatter)
+(NSString *)formatDateToLatinoAmericanFormat:(NSString *)dateToFormat;
@end

NS_ASSUME_NONNULL_END
