//
//  TvShowCollectionViewCellTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "TvShowCollectionViewCell.h"

@interface TvShowCollectionViewCellTests : XCTestCase

@property (nonatomic, strong) TvShowCollectionViewCell *cell;

@end

@implementation TvShowCollectionViewCellTests


- (void)setUp {
    
    [super setUp];
    
    self.cell = [[TvShowCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    self.cell.moviePoster = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.cell.movieTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.cell.movieReleaseDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
    self.cell.moviePopularityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 20)];
    self.cell.movieDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 40)];
}

- (void)tearDown {
    
    self.cell = nil;
    
    [super tearDown];
}

- (void)testAddShimmerEffect {
    
    XCTAssertEqual(self.cell.shimmerLayersTest.count, 0, @"Antes de agregar el efecto, no debería haber capas de shimmer.");
    
    [self.cell addShimmerEffect];
    
    XCTAssertGreaterThan(self.cell.shimmerLayersTest.count, 0, @"Debería haber capas de shimmer después de agregar el efecto.");
    
    for (UIView *view in self.cell.viewsToAnimateTest) {
        BOOL hasShimmerLayer = NO;
        for (CALayer *layer in view.layer.sublayers) {
            if ([layer isKindOfClass:[CAGradientLayer class]]) {
                hasShimmerLayer = YES;
                break;
            }
        }
        XCTAssertTrue(hasShimmerLayer, @"Cada vista debería tener una capa de shimmer después de agregar el efecto.");
    }
}

- (void)testRemoveShimmerEffect {
    
    [self.cell addShimmerEffect];
    
    
    [self.cell removeShimmerEffect];
    
    
    XCTAssertNil(self.cell.shimmerLayersTest, @"Las capas de shimmer deberían eliminarse.");
    
    for (UIView *view in self.cell.viewsToAnimateTest) {
        
        BOOL hasShimmerLayer = NO;
        
        for (CALayer *layer in view.layer.sublayers) {
            
            if ( [layer isKindOfClass: [CAGradientLayer class] ] ) {
                
                hasShimmerLayer = YES;
                break;
            }
        }
        XCTAssertFalse(hasShimmerLayer, @"Las vistas no deberían tener capas de shimmer después de eliminar el efecto.");
    }
}

@end
