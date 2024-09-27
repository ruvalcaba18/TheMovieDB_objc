//
//  TvShowCollectionViewCell.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowCollectionViewCell.h"
@interface TvShowCollectionViewCell()
@property (nonatomic, strong) NSArray<CAGradientLayer *> *shimmerLayers;
@property (nonatomic, strong) NSArray<UIView *> *viewsToAnimate;
@end

@implementation TvShowCollectionViewCell
@synthesize movieTitle,moviePoster,moviePopularityLabel,movieDescriptionLabel,movieReleaseDateLabel,viewsToAnimate,shimmerLayers,shimmerLayersTest,viewsToAnimateTest;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (CAGradientLayer *)createShimmerLayerForView:(UIView *)view {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    gradientLayer.colors = @[ (id)[UIColor clearColor].CGColor,
                              (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                              (id)[UIColor clearColor].CGColor];
    
    gradientLayer.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    return gradientLayer;
    
}

- (CABasicAnimation *)createShimmerAnimationForView:(UIView *)view {
    
    CABasicAnimation *shimmerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shimmerAnimation.duration = 1.0;
    shimmerAnimation.fromValue = @(-view.bounds.size.width);
    shimmerAnimation.toValue = @(view.bounds.size.width);
    shimmerAnimation.repeatCount = HUGE_VALF;
    
    return shimmerAnimation;
}

- (void)addShimmerEffect {
    
    if (self.shimmerLayers.count > 0) {
        return;
    }
    
    self.viewsToAnimate = @[self.movieTitle, self.moviePoster, self.moviePopularityLabel, self.movieDescriptionLabel, self.movieReleaseDateLabel];
    
    self.viewsToAnimateTest = @[self.movieTitle, self.moviePoster, self.moviePopularityLabel, self.movieDescriptionLabel, self.movieReleaseDateLabel];
    
    NSMutableArray<CAGradientLayer *> *gradientLayers = [NSMutableArray array];
    
    for (UIView *view in self.viewsToAnimate) {
        
        if ( view.layer.sublayers.count > 0)  {
            
            BOOL hasShimmerLayer = NO;
            
            for (CALayer *layer in view.layer.sublayers) {
                
                if ( [layer isKindOfClass: [CAGradientLayer class] ] ) {
                    
                    hasShimmerLayer = YES;
                    
                    break;
                }
            }
            
            if (hasShimmerLayer) {
                continue;
            }
            
        }

        CAGradientLayer *gradientLayer = [self createShimmerLayerForView:view];
        [view.layer addSublayer:gradientLayer];
        [gradientLayer addAnimation:[self createShimmerAnimationForView:view] forKey:@"ShimmerAnimation"];
        [gradientLayers addObject:gradientLayer];
    }
    self.shimmerLayersTest = gradientLayers;
    self.shimmerLayers = gradientLayers;
}


- (void)removeShimmerEffect {
    
    for (CAGradientLayer *gradientLayer in self.shimmerLayers) {
        [gradientLayer removeAllAnimations];
        [gradientLayer removeFromSuperlayer];
    }
    
    for (CAGradientLayer *gradientLayer in self.shimmerLayersTest) {
        [gradientLayer removeAllAnimations];
        [gradientLayer removeFromSuperlayer];
    }
    
    self.shimmerLayersTest = nil;
    self.shimmerLayers = nil;
    
    for (UIView *view in self.viewsToAnimate) {
        if (view.layer.mask) {
            view.layer.mask = nil;
        }
    }

    for (UIView *view in self.viewsToAnimateTest) {
        if (view.layer.mask) {
            view.layer.mask = nil;
        }
    }
}

@end
