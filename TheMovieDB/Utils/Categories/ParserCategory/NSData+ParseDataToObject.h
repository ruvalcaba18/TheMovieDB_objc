//
//  NSData+ParseDataToObject.h
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import <Foundation/Foundation.h>
#import "PostersObject.h"
#import "TvShowsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ParseDataToObject)

+ (PostersObject *)parsePosterData:(NSData *)posterData;
+ (NSMutableArray *)parseTvShowData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
