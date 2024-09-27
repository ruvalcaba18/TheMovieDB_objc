//
//  DatesModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatesModel : NSObject
@property (atomic, strong, nullable) NSString *maximum;
@property (atomic,strong, nullable) NSString *minimum;
@end

NS_ASSUME_NONNULL_END
