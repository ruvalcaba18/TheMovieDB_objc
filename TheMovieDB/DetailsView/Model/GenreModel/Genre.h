//
//  Genre.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Genre : NSObject
@property (nonatomic, assign) NSInteger genreId;
@property (nonatomic, strong) NSString *name;
@end

NS_ASSUME_NONNULL_END
