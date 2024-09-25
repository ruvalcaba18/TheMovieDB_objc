//
//  User.h
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

-(instancetype)initUserWithUsername:(NSString *_Nonnull)username andPassword:(NSString *_Nonnull) password;
-(NSString *)getUsername;
-(NSString *)getPassword;
@end

NS_ASSUME_NONNULL_END
