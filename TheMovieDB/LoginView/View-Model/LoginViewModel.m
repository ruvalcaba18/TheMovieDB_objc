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
-(BOOL)checkValidUsername:(NSString *_Nonnull)username andValidPassword:(NSString *_Nonnull) password;
-(void)retrieveUsersFromJsonFile;

@end

#pragma mark: - Implementation
@implementation LoginViewModel
@synthesize users,testusers;

-(instancetype)initViewModel {
    self = [super init];
    if (self) {
       self.users = [NSMutableArray array];
       [self retrieveUsersFromJsonFile];
    }
    return self;
}

- (BOOL)isUserCanLogin:(NSString * _Nonnull)username withPassword:(NSString * _Nonnull)password
{
   return [self checkValidUsername:username andValidPassword:password];
  
}

- (BOOL)checkValidUsername:(NSString *)username andValidPassword:(NSString *)password
{
    
    for (User *usersStoredInArray in self.users) {
        if ( [usersStoredInArray.getUsername  isEqualToString:username] ) {
            if ( [usersStoredInArray.getPassword isEqualToString:password]) {
                return YES;
            } else {
                return NO;
            }
        }
    }

    return NO;
}

- (void)retrieveUsersFromJsonFile {
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"UsersToRetrieve" ofType:@"json"];
    
    if ( !filepath ) {
        
        NSLog(@"Filepath not found");
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filepath];
    
    if( !jsonData ) {
        
        NSLog(@"There is no posible to read the jsonData");
    }
    
    NSError *errorFromSerealization;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions
                                                               error:&errorFromSerealization];
    if( errorFromSerealization ) {
        
        NSLog(@"Error to parse information in the file : %@ -> %@",filepath,errorFromSerealization);
    }
    
    NSArray *userArray = jsonDict[@"users"];
    
    for(NSDictionary *usersDict in userArray)  {
        
        NSString *username = usersDict[@"username"];
        NSString *password = usersDict[@"password"];
        
        User *existinUserInServer = [[User alloc] initUserWithUsername:username andPassword:password];
        [self.users  addObject:existinUserInServer];
    }
}

@end
