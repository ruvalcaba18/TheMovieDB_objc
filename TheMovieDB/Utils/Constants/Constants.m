//
//  Constants.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NSString* const baseURL = @"https://api.themoviedb.org/3/";
NSString* const baseImagesURL = @"https://image.tmdb.org/t/p/w500";
NSString* const baseMovieImagesURL = @"https://api.themoviedb.org/3/movie";
NSString* const discoverEndpoint = @"discover/";
NSString* const tvShowsEndPoint = @"tv";
NSString* const movieEndpoint = @"movie";
NSString* const tvShowsEndPointTopRated = @"include_adult=false&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=200";
NSString* const tvShowsEndPointPopular = @"include_adult=true&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=200";
NSString* const tvShowsEndPointOnTheAir  = @"include_adult=true&language=en-US&page=1&sort_by=popularity.desc&air_date.lte={max_date}&air_date.gte={min_date}";
NSString* const tvShowsEndPointAiringToday = @"include_adult=true&language=en-US&page=1&sort_by=popularity.desc&air_date.lte={max_date}&air_date.gte={min_date}";
NSString* const movieMostPopularEndpoint = @"include_adult=true&include_video=false&language=en-US&page=1&sort_by=popularity.desc";
NSString* const movieMostTopRatedEndpoint = @"include_adult=true&include_video=true&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200";
NSString* const movieNowPlayingEndpoint = @"include_adult=true&include_video=true&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}";
NSString* const movieUpcomingEndpoint = @"include_adult=true&include_video=true&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}";
NSString* const apiKey = @"b64d7f3ead34bfc2d9ade2eb40d81e37";
NSString* const tvShowCellIdentifier = @"tvShowCustomCellIdentifier";
NSString* const RoundedCellIdentifier = @"RoundedCellIdentifier";
NSString* const LoginTitle = @"Login";
NSString* const TvShowsTitle = @"Tv shows";
NSString* const MovieTitle = @"Movie Shows";
NSString* const creditsEndPoint = @"credits";
