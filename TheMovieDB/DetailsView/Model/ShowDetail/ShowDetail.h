//
//  ShowDetail.h
//  TheMovieDB
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <Foundation/Foundation.h>
#import "Actor.h"
#import "CrewMember.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowDetail : NSObject

@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSArray<Actor *> *cast;
@property (nonatomic, strong) NSArray<CrewMember *> *crew;

@end

NS_ASSUME_NONNULL_END
