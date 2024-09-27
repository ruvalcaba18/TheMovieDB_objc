//
//  TvShowsModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvShowsModel.h"
#import "TvShowsPopularModel.h"

@interface TvShowsModelTests : XCTestCase
@property (nonatomic, strong) TvShowsModel *tvShowsModel;
@end

@implementation TvShowsModelTests

- (void)setUp {
    
    [super setUp];
    
    NSDictionary *tvShow1 = @{
        @"adult": @NO,
        @"backdrop_path": @"path1",
        @"genere_ids": @[@1, @2],
        @"id": @101,
        @"origin_country": @[@"US"],
        @"original_language": @"en",
        @"original_name": @"Breaking Bad",
        @"first_air_date": @"2008-01-20",
        @"name": @"Breaking Bad",
        @"overview": @"Great show",
        @"popularity": @1000,
        @"poster_path": @"poster1",
        @"vote_average": @9.5,
        @"vote_count": @500
    };
    
    NSDictionary *tvShow2 = @{
        @"adult": @NO,
        @"backdrop_path": @"path2",
        @"genere_ids": @[@3, @4],
        @"id": @102,
        @"origin_country": @[@"UK"],
        @"original_language": @"en",
        @"original_title": @"Sherlock",
        @"release_date": @"2010-07-25",
        @"title": @"Sherlock",
        @"overview": @"Detective show",
        @"popularity": @900,
        @"poster_path": @"poster2",
        @"vote_average": @8.5,
        @"vote_count": @400
    };
    
    NSArray *results = @[tvShow1, tvShow2];
    
    self.tvShowsModel = [[TvShowsModel alloc] initModelWithPageNumber:@1
                                                          totalPages:@10
                                                        totalResults:@100
                                                           andResult:results];
}

- (void)tearDown {
    self.tvShowsModel = nil;
    [super tearDown];
}

- (void)testGetResults {
  
    
    NSMutableArray<TvShowsPopularModel *> *results = [self.tvShowsModel getResults];
    
    XCTAssertEqual(results.count, 2, @"Debe haber 2 series en el resultado.");
    
    TvShowsPopularModel *firstShow = results[0];
    XCTAssertEqual(firstShow.identifier, @101, @"El ID del primer show debería ser 101.");
    XCTAssertEqualObjects(firstShow.name, @"Breaking Bad", @"El nombre del primer show debería ser 'Breaking Bad'.");
    XCTAssertEqualObjects(firstShow.original_name, @"Breaking Bad", @"El nombre original del primer show debería ser 'Breaking Bad'.");
    
    TvShowsPopularModel *secondShow = results[1];
    XCTAssertEqual(secondShow.identifier, @102, @"El ID del segundo show debería ser 102.");
    XCTAssertEqualObjects(secondShow.title, @"Sherlock", @"El título del segundo show debería ser 'Sherlock'.");
}

@end
