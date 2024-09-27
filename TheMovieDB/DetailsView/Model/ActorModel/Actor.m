//
//  Actor.m
//  TheMovieDB
//
//  Created by The Coding Kid on 27/09/2024.
//

#import "Actor.h"

@implementation Actor
@synthesize adult,gender,actorId,knownForDepartment,name,originalName,popularity,profilePath,character,creditId,order;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        self.adult = [dictionary[@"adult"] boolValue];
        self.gender = [dictionary[@"gender"] integerValue];
        self.creditId = dictionary[@"id"];
        self.knownForDepartment = dictionary[@"known_for_department"];
        self.name = dictionary[@"name"];
        self.originalName = dictionary[@"original_name"];
        self.popularity = dictionary[@"popularity"] ;
        self.profilePath = dictionary[@"profile_path"];
        self.character = dictionary[@"character"];
        self.creditId = dictionary[@"credit_id"];
        self.order = [dictionary[@"order"] integerValue];
        
    }
    return self;
}
@end
