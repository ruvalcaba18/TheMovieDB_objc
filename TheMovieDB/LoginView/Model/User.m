//
//  User.m
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import "User.h"
@interface User()
@property (atomic, strong) NSString *_Nonnull username;
@property (atomic, strong) NSString *_Nonnull password;
@end

@implementation User
@synthesize username,password;

- (instancetype)initUserWithUsername:(NSString *)username andPassword:(NSString *)password
{
    if(self) {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (NSString *)getUsername {
    return self.username;
}

- (NSString *)getPassword {
    return self.password;
}
@end
