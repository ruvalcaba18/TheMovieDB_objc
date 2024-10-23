//
//  GenerateURLDetails.h
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import <Foundation/Foundation.h>
#import "URLFactory.h"
#import "OptionToSearch.h"
#import "Constants.h"
NS_ASSUME_NONNULL_BEGIN

@interface GenerateURLDetails : NSObject<URLFactory>
-(instancetype)initGenerateURLDetails;
@end

NS_ASSUME_NONNULL_END
