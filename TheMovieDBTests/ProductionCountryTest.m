//
//  ProductionCountryTest.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <XCTest/XCTest.h>
#import "ProductionCountry.h"

@interface ProductionCountryTest : XCTestCase

@property (nonatomic, strong) ProductionCountry *productionCountry;

@end

@implementation ProductionCountryTest


- (void)setUp {
    
    [super setUp];
    
    self.productionCountry = [[ProductionCountry alloc] init];
}

- (void)tearDown {
    
    self.productionCountry = nil;
    [super tearDown];
}

- (void)testIso3166_1Property {
    
    NSString *iso3166_1 = @"US";
    self.productionCountry.iso3166_1 = iso3166_1;
    
    XCTAssertEqualObjects(self.productionCountry.iso3166_1, iso3166_1, @"La propiedad 'iso3166_1' debería ser igual a la cadena proporcionada");
}

- (void)testNameProperty {
    
    NSString *name = @"United States";
    self.productionCountry.name = name;
    
    XCTAssertEqualObjects(self.productionCountry.name, name, @"La propiedad 'name' debería ser igual a la cadena proporcionada");
}


@end
