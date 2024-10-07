//
//  RetrieveFilePathManager.h
//  TheMovieDB
//
//  Created by The Coding Kid on 06/10/2024.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface RetrieveFilePathManager : NSObject

- (NSMutableArray<User*> *)retrieveUsersFromJsonFile:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
