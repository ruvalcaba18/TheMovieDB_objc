//
//  LoginViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject
@property (atomic, strong) NSMutableArray<User *> * testusers;
-(instancetype)initViewModel;
-(BOOL)isUserCanLogin:(NSString *_Nonnull)username withPassword:(NSString *_Nonnull)password;
- (void)retrieveUsersFromJsonFile;
@end

NS_ASSUME_NONNULL_END
