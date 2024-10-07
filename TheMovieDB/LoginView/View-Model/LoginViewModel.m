//
//  LoginViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import "LoginViewModel.h"

#pragma mark: - Private methods declaration
@interface LoginViewModel()

@property (atomic, strong) NSMutableArray<User *> * users;
@property (nonatomic, strong) RetrieveFilePathManager *fileManager;

-(BOOL)checkValidUsername:(NSString *_Nonnull)username andValidPassword:(NSString *_Nonnull) password;
- (User *)getUserWithUsername:(NSString *)username;
- (BOOL)isPassword:(NSString *)password validForUser:(User *)user ;

@end

#pragma mark: - Implementation
@implementation LoginViewModel
@synthesize users,testusers,fileManager;

-(instancetype)initViewModel {
    
    self = [super init];
    
    if (self) {
        
       self.users = [NSMutableArray array];
       self.fileManager = [[RetrieveFilePathManager alloc] init];
        
    }
    return self;
}

- (BOOL)isUserCanLogin:(NSString * _Nonnull)username withPassword:(NSString * _Nonnull)password {
    
   return [self checkValidUsername:username andValidPassword:password];
  
}

- (BOOL)checkValidUsername:(NSString *)username andValidPassword:(NSString *)password
{
    self.users = [self.fileManager retrieveUsersFromJsonFile:@"UsersToRetrieve"];
    
    User *user = [self getUserWithUsername:username];
    
    if (user != nil) {
        return [self isPassword:password validForUser:user];
    }
    
    return NO;
}

- (User *)getUserWithUsername:(NSString *)username {
    
    for (User *storedUser in self.users) {
        
        if ( [storedUser.getUsername isEqualToString: username] ) {
            
            return storedUser;
        }
    }
    
    return nil;
}

- (BOOL)isPassword:(NSString *)password validForUser:(User *)user {
    
    return [user.getPassword isEqualToString:password];
}

@end
