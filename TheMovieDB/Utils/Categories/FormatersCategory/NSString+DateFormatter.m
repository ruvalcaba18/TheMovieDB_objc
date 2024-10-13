//
//  NSString+DateFormatter.m
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import "NSString+DateFormatter.h"

@implementation NSString (DateFormatter)

+ (NSString *)formatDateToLatinoAmericanFormat:(NSString *)dateToFormat {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyy-MM-dd"];
    
    NSDate *date = [inputFormatter dateFromString:dateToFormat];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *formattedDate = [outputFormatter stringFromDate:date];
    return formattedDate;
}
@end
