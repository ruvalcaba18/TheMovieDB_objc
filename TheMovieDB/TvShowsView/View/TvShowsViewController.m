//
//  TvShowsViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewController.h"

@interface TvShowsViewController ()

@property (nonatomic, strong) TvShowsViewModel *viewModel;
@property (nonatomic, strong) SelectOptionView *selectOptionView;
@property (nonatomic, assign) OptionToSearch selectedOption;
@property (nonatomic, assign) BOOL isOptionSelected;

- (void)showError;
- (void)configureSegmentController;
- (void)configureOptionView;
- (void)configureCollectionView;
- (void)optionChanged:(UISegmentedControl *)sender;
- (void)subscribeToNotifications;
- (void)configureNavigationBar;

@end
@implementation TvShowsViewController

@synthesize tvSegmentControl, tvShowsCollectionView, viewModel, optionContainer, selectOptionView, selectedOption;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeViewController];
    [self configureCollectionView];
    [self configureSegmentController];
    [self subscribeToNotifications];
    [self configureNavigationBar];
    self.isOptionSelected = NO;
    
}

#pragma mark - Setup Methods

- (void)initializeViewController {
    
    self.selectOptionView = [[SelectOptionView alloc] init];
    self.viewModel = [[TvShowsViewModel alloc] initViewModel];
    [self.optionContainer addSubview:self.selectOptionView];
    [self.view bringSubviewToFront:self.optionContainer];
    [self configureOptionView];
    [self configureSegmentController];
    
}

- (void)configureNavigationBar {
    
    UINavigationBarAppearance *navAppearance = [UINavigationBarAppearance new];
    [navAppearance configureWithTransparentBackground];
    navAppearance.backgroundColor = [UIColor blackColor];
    
    NSDictionary *titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0]
    };
    
    navAppearance.titleTextAttributes = titleTextAttributes;
    self.navigationItem.standardAppearance = navAppearance;
    self.navigationItem.scrollEdgeAppearance = navAppearance;
    self.navigationItem.hidesBackButton = YES;
}

- (void)configureCollectionView {
    
    self.tvShowsCollectionView.delegate = self;
    self.tvShowsCollectionView.dataSource = self;
    [self.tvShowsCollectionView registerNib:[UINib nibWithNibName:@"TvShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:tvShowCellIdentifier];
}

- (void)configureOptionView {
    
    self.selectOptionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.selectOptionView.topAnchor constraintEqualToAnchor:self.optionContainer.topAnchor],
        [self.selectOptionView.bottomAnchor constraintEqualToAnchor:self.optionContainer.bottomAnchor],
        [self.selectOptionView.leadingAnchor constraintEqualToAnchor:self.optionContainer.leadingAnchor],
        [self.selectOptionView.trailingAnchor constraintEqualToAnchor:self.optionContainer.trailingAnchor]
    ]];
    
}

- (void)subscribeToNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleOptionSelected:)
                                                 name:@"MovieOptionSelected"
                                               object:nil];
}

#pragma mark - Actions

- (void)handleOptionSelected:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    self.selectedOption = [userInfo[@"Option"] integerValue];
    self.tvSegmentControl.hidden = NO;
    self.tvSegmentControl.userInteractionEnabled = NO;
    [self loadDataForSelectedOption:self.selectedOption isOptionSelected:YES];
    self.isOptionSelected = YES;
    [self.selectOptionView removeFromSuperview];

}

- (void)loadDataForSelectedOption:(OptionToSearch)option isOptionSelected:(BOOL)isSelected{
    
    if (isSelected) {
        [self.viewModel fetchShowsWithSearchOption: self.selectedOption];
        [self updateSegmentControlForOption:option];
        [self updateTitle];
    }
}

- (void)updateTitle {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = self.selectedOption == 0 ? TvShowsTitle : MovieTitle;
        self.tvSegmentControl.layer.mask = nil;
        self.tvSegmentControl.userInteractionEnabled = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tvShowsCollectionView reloadData];
        });

    });
}

- (void)updateSegmentControlForOption:(OptionToSearch)option {
    
    if (option == searchTvShows) {
        [self.tvSegmentControl setTitle:@"Popular Shows" forSegmentAtIndex:0];
        [self.tvSegmentControl setTitle:@"Top Rated Shows" forSegmentAtIndex:1];
        [self.tvSegmentControl setTitle:@"On Tv" forSegmentAtIndex:2];
        [self.tvSegmentControl setTitle:@"Airing Today" forSegmentAtIndex:3];
        
    } else if (option == searchMovies) {
        [self.tvSegmentControl setTitle:@"Popular Movies" forSegmentAtIndex:0];
        [self.tvSegmentControl setTitle:@"Top Rated Movies" forSegmentAtIndex:1];
        [self.tvSegmentControl setTitle:@"Now Playing Movies" forSegmentAtIndex:2];
        [self.tvSegmentControl setTitle:@"Upcoming Movies" forSegmentAtIndex:3];
    }
}

- (void)showError {
    // TODO: Implement error handling
}

- (void)configureSegmentController {
    
    self.tvSegmentControl.hidden = YES;
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    [self.tvSegmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.tvSegmentControl setTitleTextAttributes:attributes forState:UIControlStateSelected];
    [self.tvSegmentControl addTarget:self action:@selector(optionChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self applySegmentControlShimmerEffect];
    
}

- (void)applySegmentControlShimmerEffect {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = self.tvSegmentControl.bounds;
    
    gradientLayer.colors = @[ (id)[UIColor clearColor].CGColor,
                              (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                              (id)[UIColor clearColor].CGColor ];
    
    gradientLayer.locations = @[ @0.2, @0.5, @0.8 ];
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    self.tvSegmentControl.layer.mask = gradientLayer;
    
    CABasicAnimation *shimmerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shimmerAnimation.duration = 1.0;
    shimmerAnimation.fromValue = @(-self.tvSegmentControl.bounds.size.width);
    shimmerAnimation.toValue = @(self.tvSegmentControl.bounds.size.width);
    shimmerAnimation.repeatCount = HUGE_VALF;
    [gradientLayer addAnimation:shimmerAnimation forKey:@"ShimmerAnimation"];
}

- (void)optionChanged:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    TopFilter selectedFilter;

    NSArray<NSNumber *> *filters;

    if (self.selectedOption == searchTvShows) {
        
        filters = @[
            @(SearchPopularTvShows),
            @(SearchTopRatedTvShows),
            @(SearchOnTvShows),
            @(SearchAiringTodayShows)
        ];
    } else if (self.selectedOption == searchMovies) {
        
        filters = @[
            @(SearchPopularMovies),
            @(SearchTopRatedMovies),
            @(SearchNowPlayingMovies),
            @(SearchUpcomingMovies)
        ];
    }

    if (selectedIndex >= 0 && selectedIndex < filters.count) {
      
        selectedFilter = (TopFilter)[filters[selectedIndex] integerValue];
   
        [self.viewModel applyFilter:selectedFilter];
        
        [self.tvShowsCollectionView reloadData];
    }
}



#pragma mark - Collection View Delegate and DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.isOptionSelected ? MAX(self.viewModel.popularTvShows.count, 10) : 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tvShowCellIdentifier forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 15;
    cell.userInteractionEnabled = NO;
    
    TvShowsPopularModel *tvShow = self.isOptionSelected ? self.viewModel.popularTvShows[indexPath.row] : nil;
    [cell addShimmerEffect];
    
    [self.viewModel loadImageForShow:tvShow completion:^(UIImage *image, NSError *error) {
        
        if (error) {
            // TODO: Show error view
        }
        if (image) {
            
            [self configureCell:cell withImage:image andShow:tvShow];
        }
        
    }];
    
    return cell;
}

- (void)configureCell:(TvShowCollectionViewCell *)cell withImage:(UIImage *)image andShow:(TvShowsPopularModel *)tvShow {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        cell.moviePoster.image = image;
        cell.movieTitle.text = tvShow.name ?: tvShow.title;
        cell.movieDescriptionLabel.text = tvShow.overview.length > 0 ? tvShow.overview : @"No description";
        cell.moviePopularityLabel.text = [NSString stringWithFormat:@"★ %@", [self.viewModel roundToSingleDecimal:tvShow.vote_average] ];
        cell.movieReleaseDateLabel.text = [self.viewModel formatDate:tvShow.first_air_date ?: tvShow.release_date];
        
        [cell removeShimmerEffect];
        cell.userInteractionEnabled = YES;
        
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TvShowsPopularModel *selectedTvShow = self.viewModel.popularTvShows[indexPath.row];
    DetailShowViewController *detailView = [[DetailShowViewController alloc] init];
    detailView.selectedShow = selectedTvShow;
    detailView.selectedOption  = self.selectedOption;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark - Collection View Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(175, 350);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 7;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(16, 4, 0, 4);
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
