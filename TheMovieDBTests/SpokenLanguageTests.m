//
//  SpokenLanguageTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <XCTest/XCTest.h>
#import "SpokenLanguage.h"

@interface SpokenLanguageTests : XCTestCase
@property (nonatomic, strong) SpokenLanguage *spokenLanguage;
@end

@implementation SpokenLanguageTests
@synthesize spokenLanguage;

- (void)setUp {
    [super setUp];
    
    self.spokenLanguage = [[SpokenLanguage alloc] init];
}

- (void)tearDown {
    
    self.spokenLanguage = nil;
    [super tearDown];
}

- (void)testEnglishNameProperty {
    
    NSString *englishName = @"English";
    self.spokenLanguage.englishName = englishName;
    XCTAssertEqualObjects(self.spokenLanguage.englishName, englishName, @"La propiedad 'englishName' debería ser igual a la cadena proporcionada");
}

- (void)testIso6391Property {
    
    NSString *iso639_1 = @"en";
    self.spokenLanguage.iso639_1 = iso639_1;
    
    XCTAssertEqualObjects(self.spokenLanguage.iso639_1, iso639_1, @"La propiedad 'iso639_1' debería ser igual a la cadena proporcionada");
}

- (void)testNameProperty {
    
    NSString *name = @"Inglés";
    self.spokenLanguage.name = name;
    
    XCTAssertEqualObjects(self.spokenLanguage.name, name, @"La propiedad 'name' debería ser igual a la cadena proporcionada");
}


@end
