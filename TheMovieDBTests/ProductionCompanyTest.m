//
//  ProductionCompanyTest.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <XCTest/XCTest.h>
#import "ProductionCompany.h"

@interface ProductionCompanyTest : XCTestCase

@property (nonatomic, strong) ProductionCompany *productionCompany;

@end

@implementation ProductionCompanyTest

- (void)setUp {
    
    [super setUp];
    
    self.productionCompany = [[ProductionCompany alloc] init];
}

- (void)tearDown {
    
    self.productionCompany = nil;
    
    [super tearDown];
}

- (void)testCompanyIdProperty {
    
    NSInteger companyId = 123;
    self.productionCompany.companyId = companyId;
    XCTAssertEqual(self.productionCompany.companyId, companyId, @"La propiedad 'companyId' debería ser igual al valor proporcionado");
}

- (void)testLogoPathProperty {
    
    NSString *logoPath = @"path/to/logo.png";
    self.productionCompany.logoPath = logoPath;
    XCTAssertEqualObjects(self.productionCompany.logoPath, logoPath, @"La propiedad 'logoPath' debería ser igual a la cadena proporcionada");
}

- (void)testNameProperty {
    
    NSString *name = @"Company Name";
    self.productionCompany.name = name;
    XCTAssertEqualObjects(self.productionCompany.name, name, @"La propiedad 'name' debería ser igual a la cadena proporcionada");
}

- (void)testOriginCountryProperty {
    
    NSString *originCountry = @"USA";
    self.productionCompany.originCountry = originCountry;
    XCTAssertEqualObjects(self.productionCompany.originCountry, originCountry, @"La propiedad 'originCountry' debería ser igual a la cadena proporcionada");
}


@end
