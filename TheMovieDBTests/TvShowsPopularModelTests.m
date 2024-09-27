//
//  TvShowsPopularModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvShowsPopularModel.h"

@interface TvShowsPopularModelTests : XCTestCase
@property (nonatomic, strong) TvShowsPopularModel *tvShow;
@end

@implementation TvShowsPopularModelTests


- (void)setUp {
    [super setUp];
    
    self.tvShow = [[TvShowsPopularModel alloc] init];
    self.tvShow.adult = NO;
    self.tvShow.backdrop_path = @"path_to_backdrop";
    self.tvShow.genre_ids = @[@18, @10765];
    self.tvShow.identifier = @123;
    self.tvShow.origin_contry = @"US";
    self.tvShow.original_language = @"en";
    self.tvShow.original_name = @"Breaking Bad";
    self.tvShow.overview = @"A high school chemistry teacher turned methamphetamine producer.";
    self.tvShow.popularity = @987.6;
    self.tvShow.poster_path = @"path_to_poster";
    self.tvShow.first_air_date = @"2008-01-20";
    self.tvShow.name = @"Breaking Bad";
    self.tvShow.vote_average = @9.5;
    self.tvShow.vote_count = @5000;
    self.tvShow.video = NO;
    self.tvShow.title = @"Breaking Bad";
    self.tvShow.original_title = @"Breaking Bad Original";
    self.tvShow.release_date = @"2008-01-20";
}

- (void)tearDown {
    
    self.tvShow = nil;
    [super tearDown];
    
}

- (void)testTvShowProperties {
    
    XCTAssertEqual(self.tvShow.adult, NO, @"El valor de 'adult' debería ser NO.");
    XCTAssertEqualObjects(self.tvShow.backdrop_path, @"path_to_backdrop", @"El 'backdrop_path' debería ser 'path_to_backdrop'.");
    XCTAssertEqualObjects(self.tvShow.genre_ids, (@[@18, @10765]), @"Los géneros deberían ser [18, 10765].");
    XCTAssertEqual(self.tvShow.identifier, @123, @"El identificador debería ser 123.");
    XCTAssertEqualObjects(self.tvShow.origin_contry, @"US", @"El país de origen debería ser 'US'.");
    XCTAssertEqualObjects(self.tvShow.original_language, @"en", @"El idioma original debería ser 'en'.");
    XCTAssertEqualObjects(self.tvShow.original_name, @"Breaking Bad", @"El nombre original debería ser 'Breaking Bad'.");
    XCTAssertEqualObjects(self.tvShow.overview, @"A high school chemistry teacher turned methamphetamine producer.", @"La descripción debería coincidir.");
    XCTAssertEqual(self.tvShow.popularity, @987.6, @"La popularidad debería ser 987.6.");
    XCTAssertEqualObjects(self.tvShow.poster_path, @"path_to_poster", @"El 'poster_path' debería ser 'path_to_poster'.");
    XCTAssertEqualObjects(self.tvShow.first_air_date, @"2008-01-20", @"La fecha de emisión debería ser '2008-01-20'.");
    XCTAssertEqualObjects(self.tvShow.name, @"Breaking Bad", @"El nombre debería ser 'Breaking Bad'.");
    XCTAssertEqual(self.tvShow.vote_average, @9.5, @"El promedio de votos debería ser 9.5.");
    XCTAssertEqual(self.tvShow.vote_count, @5000, @"El número de votos debería ser 5000.");
    XCTAssertEqual(self.tvShow.video, NO, @"El valor de 'video' debería ser NO.");
    XCTAssertEqualObjects(self.tvShow.title, @"Breaking Bad", @"El título debería ser 'Breaking Bad'.");
    XCTAssertEqualObjects(self.tvShow.original_title, @"Breaking Bad Original", @"El título original debería ser 'Breaking Bad Original'.");
    XCTAssertEqualObjects(self.tvShow.release_date, @"2008-01-20", @"La fecha de lanzamiento debería ser '2008-01-20'.");
    
}

@end
