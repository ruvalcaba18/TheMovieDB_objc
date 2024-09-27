//
//  SeasonTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <XCTest/XCTest.h>
#import "Season.h"

@interface SeasonTests : XCTestCase

@property (nonatomic, strong) Season *season;

@end

@implementation SeasonTests


- (void)setUp {
    
    [super setUp];
    
    self.season = [[Season alloc] init];
}

- (void)tearDown {
    
    self.season = nil;
    
    [super tearDown];
}

- (void)testAirDateProperty {
    
    NSString *airDate = @"2022-09-01";
    self.season.airDate = airDate;
    
    XCTAssertEqualObjects(self.season.airDate, airDate, @"La propiedad 'airDate' debería ser igual a la cadena proporcionada");
}

- (void)testEpisodeCountProperty {
    
    NSInteger episodeCount = 10;
    self.season.episodeCount = episodeCount;
    
    XCTAssertEqual(self.season.episodeCount, episodeCount, @"La propiedad 'episodeCount' debería ser igual al valor proporcionado");
}

- (void)testSeasonIdProperty {
    
    NSInteger seasonId = 1;
    self.season.seasonId = seasonId;
    
    XCTAssertEqual(self.season.seasonId, seasonId, @"La propiedad 'seasonId' debería ser igual al valor proporcionado");
}

- (void)testNameProperty {
    
    NSString *name = @"Temporada 1";
    self.season.name = name;
    
    XCTAssertEqualObjects(self.season.name, name, @"La propiedad 'name' debería ser igual a la cadena proporcionada");
}

- (void)testOverviewProperty {
    
    NSString *overview = @"Esta es una descripción de la temporada.";
    self.season.overview = overview;
    
    XCTAssertEqualObjects(self.season.overview, overview, @"La propiedad 'overview' debería ser igual a la cadena proporcionada");
}

- (void)testPosterPathProperty {
    
    NSString *posterPath = @"/path/to/poster.jpg";
    self.season.posterPath = posterPath;
    
    XCTAssertEqualObjects(self.season.posterPath, posterPath, @"La propiedad 'posterPath' debería ser igual a la cadena proporcionada");
}

- (void)testSeasonNumberProperty {
    
    NSInteger seasonNumber = 1;
    self.season.seasonNumber = seasonNumber;
    
    XCTAssertEqual(self.season.seasonNumber, seasonNumber, @"La propiedad 'seasonNumber' debería ser igual al valor proporcionado");
}

- (void)testVoteAverageProperty {
    
    NSNumber *voteAverage = @7.5;
    self.season.voteAverage = voteAverage;
    
    XCTAssertEqualObjects(self.season.voteAverage, voteAverage, @"La propiedad 'voteAverage' debería ser igual al NSNumber proporcionado");
}


@end
