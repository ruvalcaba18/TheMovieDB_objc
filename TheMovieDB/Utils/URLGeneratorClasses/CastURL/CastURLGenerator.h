//
//  CastURLGenerator.h
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import <Foundation/Foundation.h>
#import "URLFactory.h"
#import "Constants.h"
#import "OptionToSearch.h"
NS_ASSUME_NONNULL_BEGIN

@interface CastURLGenerator : NSObject<URLFactory>
-(instancetype)initCastGenerator;
@end

NS_ASSUME_NONNULL_END
