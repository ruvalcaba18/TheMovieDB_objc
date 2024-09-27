//
//  DatesModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "DatesModel.h"

@interface DatesModelTests : XCTestCase
@property (nonatomic, strong) DatesModel *datesModel;
@end

@implementation DatesModelTests

- (void)setUp {
    
    [super setUp];
    
    self.datesModel = [[DatesModel alloc] init];
    self.datesModel.maximum = @"2024-12-31";
    self.datesModel.minimum = @"2024-01-01";
}

- (void)tearDown {
    
    self.datesModel = nil;
    
    [super tearDown];
}

- (void)testDatesModelProperties {

    XCTAssertEqualObjects(self.datesModel.maximum, @"2024-12-31", @"La fecha máxima debería ser '2024-12-31'.");
    XCTAssertEqualObjects(self.datesModel.minimum, @"2024-01-01", @"La fecha mínima debería ser '2024-01-01'.");
    
}

- (void)testDatesModelNullableProperties {
    
    self.datesModel.maximum = nil;
    self.datesModel.minimum = nil;

    XCTAssertNil(self.datesModel.maximum, @"La fecha máxima debería ser nula.");
    XCTAssertNil(self.datesModel.minimum, @"La fecha mínima debería ser nula.");
    
}
@end
