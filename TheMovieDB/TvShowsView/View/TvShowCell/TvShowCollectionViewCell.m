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


@end
