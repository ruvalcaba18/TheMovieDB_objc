//
//  ProductionCompany.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductionCompany : NSObject

@property (nonatomic, assign) NSInteger companyId;
@property (nonatomic, strong) NSString *logoPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *originCountry;

@end

NS_ASSUME_NONNULL_END
