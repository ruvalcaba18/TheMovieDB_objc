//
//  ImagesEndpointTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "ImagesEndpoint.h"

@interface ImagesEndpointTests : XCTestCase

@property (nonatomic, strong) ImagesEndpoint *imagesEndpoint;

@end

@implementation ImagesEndpointTests

- (void)setUp {
    
    [super setUp];
    
    self.imagesEndpoint = [[ImagesEndpoint alloc] init];
    self.imagesEndpoint.backdrops = @[@{@"url": @"backdrop1.jpg"}, @{@"url": @"backdrop2.jpg"}];
    self.imagesEndpoint.identifier = @101;
    self.imagesEndpoint.logos = @[@{@"url": @"logo1.png"}, @{@"url": @"logo2.png"}];
    self.imagesEndpoint.posters = @[@{@"url": @"poster1.jpg"}, @{@"url": @"poster2.jpg"}];
}

- (void)tearDown {
    
    self.imagesEndpoint = nil;
    
    [super tearDown];
}

- (void)testImagesEndpointProperties {

    XCTAssertEqualObjects(self.imagesEndpoint.backdrops, (@[@{@"url": @"backdrop1.jpg"}, @{@"url": @"backdrop2.jpg"}]), @"Los backdrops deberían ser correctamente asignados.");
    XCTAssertEqual(self.imagesEndpoint.identifier, @101, @"El identificador debería ser 101.");
    XCTAssertEqualObjects(self.imagesEndpoint.logos, (@[@{@"url": @"logo1.png"}, @{@"url": @"logo2.png"}]), @"Los logos deberían ser correctamente asignados.");
    XCTAssertEqualObjects(self.imagesEndpoint.posters, (@[@{@"url": @"poster1.jpg"}, @{@"url": @"poster2.jpg"}]), @"Los posters deberían ser correctamente asignados.");
    
}
@end
