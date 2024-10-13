//
//  NSNumber+RoundFigures.h
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (RoundFigures)
+ (NSNumber *)roundToSingleDecimal:(NSNumber*)number ;
@end

NS_ASSUME_NONNULL_END
