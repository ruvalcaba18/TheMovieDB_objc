//
//  URLGenerator.h
//  TheMovieDB
//
//  Created by The Coding Kid on 14/10/2024.
//

#import <Foundation/Foundation.h>
#import "TopFilterOption.h"
#import "OptionToSearch.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface URLGenerator : NSObject

+(NSString *) generateURLForFilter:(TopFilter)topFilter;
+(NSString *) generateURLForOption:(OptionToSearch)option;
+(NSString *) generateURLForDetailOption:(OptionToSearch)option  withIdentifier:(NSString *)identifier;
+(NSString *) generateURLForCastOption:(OptionToSearch)option forIDShow:(NSInteger)showID;
+(NSString *) generateURLToRetrieveImagesForTvShowsWithIdentifier:(NSInteger)identifier;
+(NSString *) generateURLToRetrieveImagesForMoviesWithIdentifier:(NSInteger)identifier;
@end

NS_ASSUME_NONNULL_END
