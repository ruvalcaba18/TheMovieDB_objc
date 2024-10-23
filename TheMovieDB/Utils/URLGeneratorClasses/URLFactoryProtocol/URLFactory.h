//
//  URLFactory.h
//  TheMovieDB
//
//  Created by The Coding Kid on 20/10/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol URLFactory <NSObject>

@property (nonatomic,strong) NSMutableDictionary *entertainmentStorage;
-(NSString* _Nonnull)generateURLFor:(NSInteger)movieOrShow withIdentifier:(NSInteger )identifier;
-(void)constructDictionary;
-(NSString *)getEndpointForOption:(NSInteger)option;

@end

NS_ASSUME_NONNULL_END
