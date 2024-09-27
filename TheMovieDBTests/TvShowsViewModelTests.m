//
//  TvShowsViewModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvShowsViewModel.h"
#import "TvShowsPopularModel.h"

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

- (void)testApplyFilter {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Apply Filter"];
    
    [self.viewModel applyFilter:SearchPopularTvShows];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssertNotNil(self.viewModel.popularTvShows, @"Filtered TV shows should be fetched.");
        XCTAssertGreaterThan(self.viewModel.popularTvShows.count, 0, @"There should be at least one filtered TV show.");
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}


- (void)testLoadImageForShow {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load Image"];
    
    TvShowsPopularModel *mockTvShow = [[TvShowsPopularModel alloc] init];
    mockTvShow.identifier = @(1022789);
    mockTvShow.poster_path = @"/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg";
    
    [self.viewModel loadImageForShow:mockTvShow completion:^(UIImage *image, NSError *error) {
        XCTAssertNotNil(image, @"Image should be downloaded.");
        XCTAssertNil(error, @"There should be no error.");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:nil];
}


- (void)testFormatDate {
    
    NSString *formattedDate = [self.viewModel formatDate:@"2023-09-26"];
    XCTAssertEqualObjects(formattedDate, @"Sep 26, 2023", @"Date should be correctly formatted.");
}


@end
