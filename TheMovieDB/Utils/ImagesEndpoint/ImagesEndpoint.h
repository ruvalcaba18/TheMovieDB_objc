//
//  ImagesEndpoint.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagesEndpoint : NSObject
@property (atomic, strong) NSArray *backdrops;
@property (atomic, strong) NSNumber *identifier;
@property (atomic, strong) NSArray *logos;
@property (atomic, strong) NSArray *posters;
@end

NS_ASSUME_NONNULL_END
