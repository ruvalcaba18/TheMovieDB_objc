//
//  TvShowCollectionViewCell.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowCollectionViewCell.h"
@interface TvShowCollectionViewCell()

@end

@implementation TvShowCollectionViewCell
@synthesize movieTitle,moviePoster,moviePopularityLabel,movieDescriptionLabel,movieReleaseDateLabel;

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

- (void)addShimmerEffect {
        
    CAGradientLayer *gradientLayerForTitle = [CAGradientLayer layer];
    CAGradientLayer *gradientLayerForPoster = [CAGradientLayer layer];
    CAGradientLayer *gradientLayerForPopularity = [CAGradientLayer layer];
    CAGradientLayer *gradientLayerForDescription = [CAGradientLayer layer];
    CAGradientLayer *gradientLayerForDate = [CAGradientLayer layer];
    
    gradientLayerForTitle.frame = self.movieTitle.bounds;
    gradientLayerForPoster.frame = self.moviePoster.bounds;
    gradientLayerForPopularity.frame = self.moviePopularityLabel.bounds;
    gradientLayerForDescription.frame = self.movieDescriptionLabel.bounds;
    gradientLayerForDate.frame = self.movieReleaseDateLabel.bounds;
    
    gradientLayerForTitle.colors = @[ (id)[UIColor clearColor].CGColor,
                                      (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                      (id)[UIColor clearColor].CGColor];
    
    gradientLayerForPoster.colors =  @[ (id)[UIColor clearColor].CGColor,
                                        (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                        (id)[UIColor clearColor].CGColor];
    
    gradientLayerForPopularity.colors =  @[ (id)[UIColor clearColor].CGColor,
                                            (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                            (id)[UIColor clearColor].CGColor];
    
    gradientLayerForDescription.colors =  @[ (id)[UIColor clearColor].CGColor,
                                             (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                             (id)[UIColor clearColor].CGColor];
    
    gradientLayerForDate.colors =  @[ (id)[UIColor clearColor].CGColor,
                                      (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                      (id)[UIColor clearColor].CGColor];
    
    gradientLayerForTitle.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayerForPoster.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayerForPopularity.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayerForDescription.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayerForDate.locations = @[ @0.2, @0.5, @0.8 ];
    
    gradientLayerForTitle.startPoint = CGPointMake(0.0, 0.5);
    gradientLayerForPoster.startPoint = CGPointMake(0.0, 0.5);
    gradientLayerForPopularity.startPoint = CGPointMake(0.0, 0.5);
    gradientLayerForDescription.startPoint = CGPointMake(0.0, 0.5);
    gradientLayerForDate.startPoint = CGPointMake(0.0, 0.5);
    
    gradientLayerForTitle.endPoint = CGPointMake(1.0, 0.5);
    gradientLayerForPoster.endPoint = CGPointMake(1.0, 0.5);
    gradientLayerForPopularity.endPoint = CGPointMake(1.0, 0.5);
    gradientLayerForDescription.endPoint = CGPointMake(1.0, 0.5);
    gradientLayerForDate.endPoint = CGPointMake(1.0, 0.5);
    
    self.movieTitle.layer.mask = gradientLayerForTitle;
    self.moviePoster.layer.mask = gradientLayerForPoster;
    self.moviePopularityLabel.layer.mask = gradientLayerForPopularity;
    self.movieDescriptionLabel.layer.mask = gradientLayerForDescription;
    self.movieReleaseDateLabel.layer.mask = gradientLayerForDate;
    
    CABasicAnimation *titleAnimationShimmer = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    titleAnimationShimmer.duration = 1.0;
    titleAnimationShimmer.fromValue = @(-self.movieTitle.bounds.size.width);
    titleAnimationShimmer.toValue = @(self.movieTitle.bounds.size.width);
    titleAnimationShimmer.repeatCount = HUGE_VALF;
    
    CABasicAnimation *posterAnimationShimmer = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    posterAnimationShimmer.duration = 1.0;
    posterAnimationShimmer.fromValue = @(-self.moviePoster.bounds.size.width);
    posterAnimationShimmer.toValue = @(self.moviePoster.bounds.size.width);
    posterAnimationShimmer.repeatCount = HUGE_VALF;
    
    CABasicAnimation *popularityAnimationShimmer = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    popularityAnimationShimmer.duration = 1.0;
    popularityAnimationShimmer.fromValue = @(-self.moviePopularityLabel.bounds.size.width);
    popularityAnimationShimmer.toValue = @(self.moviePopularityLabel.bounds.size.width);
    popularityAnimationShimmer.repeatCount = HUGE_VALF;
    
    CABasicAnimation *descriptionAnimationShimmer = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    descriptionAnimationShimmer.duration = 1.0;
    descriptionAnimationShimmer.fromValue = @(-self.movieDescriptionLabel.bounds.size.width);
    descriptionAnimationShimmer.toValue = @(self.movieDescriptionLabel.bounds.size.width);
    descriptionAnimationShimmer.repeatCount = HUGE_VALF;
    
    CABasicAnimation *releaseDateAnimationShimmer = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    releaseDateAnimationShimmer.duration = 1.0;
    releaseDateAnimationShimmer.fromValue = @(-self.movieReleaseDateLabel.bounds.size.width);
    releaseDateAnimationShimmer.toValue = @(self.movieReleaseDateLabel.bounds.size.width);
    releaseDateAnimationShimmer.repeatCount = HUGE_VALF;
    
    [gradientLayerForTitle addAnimation:titleAnimationShimmer forKey:@"ShimmerTitleAnimation"];
    [gradientLayerForPoster addAnimation:posterAnimationShimmer forKey:@"ShimmerPosterAnimation"];
    [gradientLayerForPopularity addAnimation:popularityAnimationShimmer forKey:@"ShimmerPopularityAnimation"];
    [gradientLayerForDescription addAnimation:descriptionAnimationShimmer forKey:@"ShimmerDescriptionAnimation"];
    [gradientLayerForDate addAnimation:releaseDateAnimationShimmer forKey:@"ShimmerDateReleasenAnimation"];
}

- (void)removeShimmerEffect {
    self.movieTitle.layer.mask = nil;
    self.moviePoster.layer.mask = nil;
    self.moviePopularityLabel.layer.mask = nil;
    self.movieDescriptionLabel.layer.mask = nil;
    self.movieReleaseDateLabel.layer.mask = nil;
}


@end
