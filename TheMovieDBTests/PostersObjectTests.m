//
//  PostersObjectTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "PostersObject.h"

@interface PostersObjectTests : XCTestCase

@property (nonatomic, strong) PostersObject *poster;

@end

@implementation PostersObjectTests


- (void)setUp {
    [super setUp];
    
    self.poster = [[PostersObject alloc] init];
    self.poster.aspect_ratio = @1.77;
    self.poster.height = @1080;
    self.poster.iso_639_1 = @"en";
    self.poster.file_path = @"/path/to/poster.jpg";
    self.poster.vote_average = @8.5;
    self.poster.vote_count = @1500;
    self.poster.width = @1920;
}

- (void)tearDown {
    self.poster = nil;
    [super tearDown];
}

- (void)testPosterProperties {

    XCTAssertEqual(self.poster.aspect_ratio, @1.77, @"El aspect_ratio debería ser 1.77.");
    XCTAssertEqual(self.poster.height, @1080, @"La altura debería ser 1080.");
    XCTAssertEqualObjects(self.poster.iso_639_1, @"en", @"El código de idioma debería ser 'en'.");
    XCTAssertEqualObjects(self.poster.file_path, @"/path/to/poster.jpg", @"El file_path debería ser '/path/to/poster.jpg'.");
    XCTAssertEqual(self.poster.vote_average, @8.5, @"El promedio de votos debería ser 8.5.");
    XCTAssertEqual(self.poster.vote_count, @1500, @"El número de votos debería ser 1500.");
    XCTAssertEqual(self.poster.width, @1920, @"El ancho debería ser 1920.");
    
}


@end
