//
//  LoginViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "RetrieveFilePathManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (atomic, strong) NSMutableArray<User *> * testusers;
-(instancetype)initViewModel;
-(BOOL)isUserCanLogin:(NSString *_Nonnull)username withPassword:(NSString *_Nonnull)password;
@end

NS_ASSUME_NONNULL_END
