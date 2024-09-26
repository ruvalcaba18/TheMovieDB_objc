//
//  PostersObject.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostersObject : NSObject
@property (atomic, strong) NSNumber *aspect_ratio;
@property (atomic, strong) NSNumber *height;
@property (atomic, assign) id iso_639_1;
@property (atomic, strong) NSString *file_path;
@property (atomic, strong) NSNumber *vote_average;
@property (atomic, strong) NSNumber *vote_count;
@property (atomic, strong) NSNumber *width;
@end

NS_ASSUME_NONNULL_END
