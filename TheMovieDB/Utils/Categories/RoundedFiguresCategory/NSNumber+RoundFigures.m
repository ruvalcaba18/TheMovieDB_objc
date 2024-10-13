//
//  NSNumber+RoundFigures.m
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import "NSNumber+RoundFigures.h"

@implementation NSNumber (RoundFigures)

+ (NSNumber *)roundToSingleDecimal:(NSNumber*)number {
    
    if ( ![number isKindOfClass: [NSNumber class] ] ) {
        NSLog(@"El valor proporcionado no es un NSNumber: %@", number);
        return @(0) ;
    }
    double roundedValue = round([number doubleValue] * 10 ) / 10;
    return [NSNumber numberWithDouble:roundedValue];
}

@end
