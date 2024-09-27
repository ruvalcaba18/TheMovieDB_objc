//
//  TvSerieTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvSerie.h"

@interface TvSerieTests : XCTestCase
@property (nonatomic, strong) TvSerie *tvSerie;
@end

@implementation TvSerieTests
@synthesize tvSerie;

-(void)setUp {
    
   [super setUp];
    
   self.tvSerie = [[TvSerie alloc] init];
}

- (void)tearDown {
    
   self.tvSerie = nil;
    
   [super tearDown];
}

- (void)testAdultProperty {
    
   self.tvSerie.adult = YES;
    
   XCTAssertTrue(self.tvSerie.adult, @"La propiedad 'adult' debería ser YES");
}

- (void)testBackdropPathProperty {
    
   NSString *backdropPath = @"path/to/backdrop.jpg";
    
   self.tvSerie.backdropPath = backdropPath;
   XCTAssertEqualObjects(self.tvSerie.backdropPath, backdropPath, @"La propiedad 'backdropPath' debería ser igual a la ruta proporcionada");
}

- (void)testCreatedByProperty {
    
   Creator *creator = [[Creator alloc] init];
    
   self.tvSerie.createdBy = @[creator];
   XCTAssertEqual(self.tvSerie.createdBy.count, 1, @"La propiedad 'createdBy' debería contener un creador");
}

- (void)testVoteAverageProperty {
    
   self.tvSerie.voteAverage = @7.5;
    
   XCTAssertEqualObjects(self.tvSerie.voteAverage, @7.5, @"La propiedad 'voteAverage' debería ser 7.5");
}

- (void)testVoteCountProperty {
    
   self.tvSerie.voteCount = 1500;
    
   XCTAssertEqual(self.tvSerie.voteCount, 1500, @"La propiedad 'voteCount' debería ser 1500");
}

- (void)testPopularityProperty {
    
   self.tvSerie.popularity = @10.0;
    
   XCTAssertEqualObjects(self.tvSerie.popularity, @10.0, @"La propiedad 'popularity' debería ser 10.0");
}


@end
