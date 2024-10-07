//
//  RetrieveFilePathManager.m
//  TheMovieDB
//
//  Created by The Coding Kid on 06/10/2024.
//

#import "RetrieveFilePathManager.h"

@implementation RetrieveFilePathManager

- (NSMutableArray<User*> *)retrieveUsersFromJsonFile:(NSString *)fileName {
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSMutableArray *retreivedUsers = [NSMutableArray array];
    
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
        [retreivedUsers  addObject:existinUserInServer];
    }
    
    return retreivedUsers;
}


@end
