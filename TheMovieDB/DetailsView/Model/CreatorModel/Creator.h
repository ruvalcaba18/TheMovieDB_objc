//
//  Creator.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Creator : NSObject
@property (nonatomic, assign) NSInteger creatorId;
@property (nonatomic, strong) NSString *creditId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *originalName;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString *profilePath;
@end

NS_ASSUME_NONNULL_END
