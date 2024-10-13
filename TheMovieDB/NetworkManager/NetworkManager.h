//
//  NetworkManager.h
//  TheMovieDB
//
//  Created by The Coding Kid on 09/10/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject
+ (void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
