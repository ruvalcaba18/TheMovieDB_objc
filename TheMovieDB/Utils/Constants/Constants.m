//
//  Constants.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NSString* const baseURL = @"https://api.themoviedb.org/3/";
NSString* const baseImagesURL = @"https://image.tmdb.org/t/p/original";
NSString* const discoverEndpoint = @"discover/";
NSString* const tvShowsEndPoint = @"tv";
NSString* const tvShowsEndPointTopRated = @"include_adult=false&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=200";
NSString* const tvShowsEndPointPopular = @"include_adult=true&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=200";
NSString* const tvShowsEndPointOnTheAir  = @"include_adult=true&language=en-US&page=1&sort_by=popularity.desc&air_date.lte={max_date}&air_date.gte={min_date}";
NSString* const tvShowsEndPointAiringToday = @"include_adult=false&language=en-US&page=1&sort_by=popularity.desc&air_date.lte={max_date}&air_date.gte={min_date}";
NSString* const apiKey = @"b64d7f3ead34bfc2d9ade2eb40d81e37";
NSString* const tvShowCellIdentifier = @"tvShowCustomCellIdentifier";
NSString* const LoginTitle = @"Login";
NSString* const TvShowsTitle = @"Tv shows";
NSString* const MovieTitle = @"Movie Shows";
