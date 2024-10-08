//
//  TvShowCollectionViewCell.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TvShowCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *moviePoster;
@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (strong, nonatomic) IBOutlet UILabel *movieReleaseDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *moviePopularityLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieDescriptionLabel;
@property (nonatomic, strong) NSArray<CAGradientLayer *> *_Nullable shimmerLayersTest;
@property (nonatomic, strong) NSArray<UIView *> *_Nullable viewsToAnimateTest;
-(void)addShimmerEffect;
-(void)removeShimmerEffect;
@end

NS_ASSUME_NONNULL_END
