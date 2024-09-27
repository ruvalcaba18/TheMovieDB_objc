//
//  CastMember.h
//  TheMovieDB
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CastMember : NSObject

@property (nonatomic, assign) BOOL adult;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger castID;
@property (nonatomic, strong) NSString *knownForDepartment;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *originalName;
@property (nonatomic, strong) NSNumber *popularity; 
@property (nonatomic, strong) NSString *profilePath;
@property (nonatomic, strong) NSString *character;
@property (nonatomic, strong) NSString *creditID;
@property (nonatomic, assign) NSInteger order;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
