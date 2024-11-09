//
//  TvShowsViewModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvShowsViewModel.h"
#import "TvShowsPopularModel.h"
#import "NSString+DateFormatter.h"

@interface TvShowsViewModelTests : XCTestCase

@property (nonatomic, strong) TvShowsViewModel *viewModel;

@end

@implementation TvShowsViewModelTests

- (void)setUp {
    
    [super setUp];
    
    self.viewModel = [[TvShowsViewModel alloc] initViewModel];
}

- (void)tearDown {
    
    self.viewModel = nil;
    [super tearDown];
}

- (void)testFetchShowsWithSearchOption {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch TV Shows"];
    
    [self.viewModel fetchShowsWithSearchOption:searchTvShows];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertNotNil(self.viewModel.popularTvShows, @"Tv shows should be fetched.");
        XCTAssertGreaterThan(self.viewModel.popularTvShows.count, 0, @"There should be at least one TV show.");
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testApplyAllFilters {
    
    NSArray *filterOptions = @[@(SearchPopularTvShows),
                               @(SearchTopRatedTvShows),
                               @(SearchOnTvShows),
                               @(SearchAiringTodayShows),
                               @(SearchNowPlayingMovies),
                               @(SearchPopularMovies),
                               @(SearchTopRatedMovies),
                               @(SearchUpcomingMovies)];

    for (NSNumber *filterOption in filterOptions) {
        [self runTestForFilter: [filterOption intValue] ];
    }
    
}

- (void)runTestForFilter:(TopFilter)filterOption {
    
    NSString *filterDescription;
    
    switch (filterOption) {
            
        case SearchPopularTvShows:
            filterDescription = @"Popular TV Shows";
            break;
        case SearchTopRatedTvShows:
            filterDescription = @"Top Rated TV Shows";
            break;
        case SearchOnTvShows:
            filterDescription = @"Currently On TV Shows";
            break;
        case SearchAiringTodayShows:
            filterDescription = @"Airing Today TV Shows";
            break;
        case SearchNowPlayingMovies:
            filterDescription = @"Now Playing Movies";
            break;
        case SearchPopularMovies:
            filterDescription = @"Popular Movies";
            break;
        case SearchTopRatedMovies:
            filterDescription = @"Top Rated Movies";
            break;
        case SearchUpcomingMovies:
            filterDescription = @"Upcoming Movies";
            break;
    }
    
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"Apply Filter: %@", filterDescription]];
    
    [self.viewModel applyFilter:filterOption];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        XCTAssertNotNil(self.viewModel.popularTvShows, @"Filtered %@ should be fetched.", filterDescription);
        XCTAssertGreaterThan(self.viewModel.popularTvShows.count, 0, @"There should be at least one result for %@.", filterDescription);
        [expectation fulfill];
        
    });
    
    [self waitForExpectationsWithTimeout:15 handler:nil];
    
}


- (void)test_LoadImageForMovie {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load Image"];
    
    TvShowsPopularModel *mockTvShow = [[TvShowsPopularModel alloc] init];
    mockTvShow.title = @"Transformers One";
    mockTvShow.identifier = @(1022789);
    mockTvShow.poster_path = @"/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg";
    
    [self.viewModel loadImage:mockTvShow completion:^(UIImage *image, NSError *error) {
        XCTAssertNotNil(image, @"Image should be downloaded.");
        XCTAssertNil(error, @"There should be no error.");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:nil];
}

- (void)test_LoadImageForTVShow {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load Image"];
    
    TvShowsPopularModel *mockTvShow = [[TvShowsPopularModel alloc] init];
    mockTvShow.title = @"Breaking Bad";
    mockTvShow.identifier = @(1022799);
    mockTvShow.poster_path = @"/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg";
    
    [self.viewModel loadImage:mockTvShow completion:^(UIImage *image, NSError *error) {
        XCTAssertNotNil(image, @"Image should be downloaded.");
        XCTAssertNil(error, @"There should be no error.");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:nil];
}


- (void)testFormatDate {
    
    NSString *formattedDate = [NSString formatDateToLatinoAmericanFormat:@"2023-09-26"];
    XCTAssertEqualObjects(formattedDate, @"Sep 26, 2023", @"Date should be correctly formatted.");
}


@end
