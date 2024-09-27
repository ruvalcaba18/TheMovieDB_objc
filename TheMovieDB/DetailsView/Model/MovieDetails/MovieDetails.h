//
//  MovieDetails.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>
#import "Genre.h"
#import "ProductionCompany.h"
#import "ProductionCountry.h"
#import "SpokenLanguage.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetails : NSObject

@property (nonatomic, assign) BOOL adult;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic, strong) NSString *belongsToCollection;
@property (nonatomic, assign) NSInteger budget;
@property (nonatomic, strong) NSArray<Genre *> *genres;
@property (nonatomic, strong) NSString *homepage;
@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSString *imdbId;
@property (nonatomic, strong) NSString *originalLanguage;
@property (nonatomic, strong) NSString *originalTitle;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, assign) CGFloat popularity;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSArray<ProductionCompany *> *productionCompanies;
@property (nonatomic, strong) NSArray<ProductionCountry *> *productionCountries;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, assign) NSInteger revenue;
@property (nonatomic, assign) NSInteger runtime;
@property (nonatomic, strong) NSArray<SpokenLanguage *> *spokenLanguages;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL video;
@property (nonatomic, assign) NSNumber* voteAverage;
@property (nonatomic, assign) NSInteger voteCount;

@end

NS_ASSUME_NONNULL_END
