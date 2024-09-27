//
//  UserTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "User.h"

@interface UserTests : XCTestCase

@property (nonatomic, strong) User *user;

@end

@implementation UserTests


- (void)setUp {
    
    [super setUp];
    
    self.user = [[User alloc] initUserWithUsername:@"codingkid" andPassword:@"coding"];
}

- (void)tearDown {
    
    self.user = nil;
    
    [super tearDown];
    
}

- (void)testUserInitialization {
    
    XCTAssertEqualObjects([self.user getUsername], @"codingkid", @"El nombre de usuario debería ser 'testUser'.");
    XCTAssertEqualObjects([self.user getPassword], @"coding", @"La contraseña debería ser 'securePassword123'.");
    
}

- (void)testUsernameGetter {
    
    NSString *username = [self.user getUsername];
    XCTAssertEqualObjects(username, @"codingkid", @"El getter del nombre de usuario debería devolver 'testUser'.");
    
}

- (void)testPasswordGetter {
    
    NSString *password = [self.user getPassword];
    XCTAssertEqualObjects(password, @"coding", @"El getter de la contraseña debería devolver 'securePassword123'.");
    
}


@end
