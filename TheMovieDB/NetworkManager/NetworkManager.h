//
//  NetworkManager.h
//  TheMovieDB
//
//  Created by The Coding Kid on 09/10/2024.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "TvShowsPopularModel.h"
#import  "URLGenerator.h"
#import "PostersObject.h"
#import "NSData+ParseDataToObject.h"
#import "Actor.h"
NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject
+ (instancetype)sharedManager;
- (void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;
- (void)loadImageForShow:(TvShowsPopularModel *)show completion:(void (^)(UIImage *image, NSError *error))completion;
- (void)loadImageForActor:(Actor * )actor completion:(void (^)(UIImage *image, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
