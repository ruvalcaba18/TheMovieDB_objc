//
//  TvShowsModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsModel.h"

@interface TvShowsModel()
@property (atomic, strong, nullable) DatesModel *dates;
@property (atomic, strong) NSNumber *pageNumber;
@property (atomic, strong) NSArray *result;
@property (atomic, strong) NSNumber *total_pages;
@property (atomic, strong) NSNumber *total_results;
@end


@implementation TvShowsModel
@synthesize pageNumber,result,total_pages,total_results;

-(instancetype)initModelWithPageNumber:(NSNumber *) pageNumber totalPages:(NSNumber *)pages totalResults:(NSNumber *)totalResults andResult:(NSArray *)results
{
    self = [super init];
    
    if(self) {
        self.pageNumber = pageNumber;
        self.total_pages = pages;
        self.total_results = totalResults;
        self.result = results;
        [self getResults];
    }
    return self;
}

- (NSMutableArray *)getResults {
    
    NSMutableArray<TvShowsPopularModel*> *allTvShows = [NSMutableArray array];
    
    for (NSDictionary *dicc in result) {
        TvShowsPopularModel *tvShow = [[TvShowsPopularModel alloc] init];
        tvShow.adult = [dicc[@"adult"] boolValue];
        tvShow.backdrop_path = dicc[@"backdrop_path"];
        tvShow.genre_ids = dicc[@"genere_ids"];
        tvShow.identifier = dicc[@"id"];
        tvShow.origin_contry = dicc[@"origin_country"];
        tvShow.original_language = dicc[@"original_language"];
        
        
        if ( dicc[@"original_name"]) {
            
            tvShow.original_name = dicc[@"original_name"];
            tvShow.first_air_date = dicc[@"first_air_date"];
            tvShow.name = dicc[@"name"];
        } else {
            
            tvShow.original_title = dicc[@"original_title"];
            tvShow.title = dicc[@"title"];
            tvShow.release_date = dicc[@"release_date"];
        }
      
        tvShow.overview = dicc[@"overview"];
        tvShow.popularity = dicc[@"popularity"];
        tvShow.poster_path = dicc[@"poster_path"];
    
        tvShow.vote_average = dicc[@"vote_average"];
        tvShow.vote_count = dicc[@"vote_count"];
        [allTvShows addObject:tvShow];
    }
    return allTvShows;
}


@end
