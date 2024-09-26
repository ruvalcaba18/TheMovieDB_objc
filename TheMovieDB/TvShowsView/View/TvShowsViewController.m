//
//  TvShowsViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewController.h"

@interface TvShowsViewController ()

@property (atomic, strong) TvShowsViewModel *viewModel;
@property (atomic, strong) SelectOptionView *selectOptionView;
@property (atomic, assign) OptionToSearch option;

-(void)displayError;
-(void)updateSegmentController;
-(void)setUpOptionView;
-(void)setUpCollectionView ;
-(void)selectOptionToRetrieve:(UISegmentedControl *) sender;
-(void)subscribeToNotification;
-(void)setUpNavigation;
@end

@implementation TvShowsViewController
@synthesize tvSegmentControl,tvShowsCollectionView,viewModel,optionContainer,selectOptionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViewController];
    [self setUpCollectionView];
    [self.viewModel starFetchFirstOption:searchTvShows];
    [self updateSegmentController];
    [self subscribeToNotification];
    [self setUpNavigation];
}


#pragma mark: - Private functions

-(void)setUpNavigation {
    UINavigationBarAppearance *navAppearance = [UINavigationBarAppearance new];
    [navAppearance configureWithTransparentBackground];
    navAppearance.backgroundColor = [UIColor blackColor];
    
    NSDictionary *titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0]
    } ;
    
    navAppearance.titleTextAttributes = titleTextAttributes;
    self.navigationItem.standardAppearance = navAppearance;
    self.navigationItem.scrollEdgeAppearance = navAppearance;
}

-(void)setUpCollectionView {
    self.tvShowsCollectionView.delegate = self;
    self.tvShowsCollectionView.dataSource = self;
    [self.tvShowsCollectionView registerNib:[UINib nibWithNibName: @"TvShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:tvShowCellIdentifier];
}

-(void)setUpViewController {
    self.selectOptionView = [[SelectOptionView alloc] init];
    self.viewModel = [[TvShowsViewModel alloc] initTvShowsViewModel];
    [self.optionContainer addSubview:self.selectOptionView];
    [self.view bringSubviewToFront:self.optionContainer];
    [self setUpOptionView];
    [self updateSegmentController];
}

-(void)setUpOptionView {
    self.selectOptionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [self.selectOptionView.topAnchor constraintEqualToAnchor:self.optionContainer.topAnchor];
    NSLayoutConstraint *bottom = [self.selectOptionView.bottomAnchor constraintEqualToAnchor:self.optionContainer.bottomAnchor];
    NSLayoutConstraint *leading = [self.selectOptionView.leadingAnchor constraintEqualToAnchor:self.optionContainer.leadingAnchor];
    NSLayoutConstraint *trailling = [self.selectOptionView.trailingAnchor constraintEqualToAnchor:self.optionContainer.trailingAnchor];
    
    top.active = YES;
    bottom.active = YES;
    leading.active = YES;
    trailling.active = YES;
}

-(void)subscribeToNotification {
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(handleOptionSelected:)
                                                  name:@"MovieOptionSelected"
                                                object:nil];
}

-(void)handleOptionSelected:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    OptionToSearch selectedOption = [userInfo[@"Option"] integerValue];
    __weak typeof(self) weakSelf = self;
    [weakSelf.selectOptionView removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        switch (selectedOption) {
            case 0: {
                weakSelf.title = TvShowsTitle;
                weakSelf.stackSegmenContainer.hidden = NO;
                break;
            }
            case 1: {
                weakSelf.title = MovieTitle;
                weakSelf.stackSegmenContainer.hidden = NO;
                break;
            }
            default:
                break;
        }
    });
    
}

- (void)displayError {
    // TODO: make display error
}

- (void)updateSegmentController {
    NSDictionary *normalAndSelectedAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.tvSegmentControl setTitleTextAttributes:normalAndSelectedAttributes forState:UIControlStateNormal];
    [self.tvSegmentControl setTitleTextAttributes:normalAndSelectedAttributes forState:UIControlStateSelected];
    [self.tvSegmentControl addTarget:self action:@selector(selectOptionToRetrieve:) forControlEvents: UIControlEventValueChanged];
}

-(void)selectOptionToRetrieve:(UISegmentedControl *) sender {
    
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:
            [self.viewModel retrieveFilterSelected: SearchPopularMovies];
            break;
        case 1:
            [self.viewModel retrieveFilterSelected: SearchTopRatedMovies];
            break;
        case 2:
            [self.viewModel retrieveFilterSelected: SearchOnTvShows];
            break;
        case 3:
            [self.viewModel retrieveFilterSelected: SearchAiringTodayShows];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark: - Collection view Delegate and Data source

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.popularTvShows count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: tvShowCellIdentifier forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 15;
    TvShowsPopularModel *tvShow = self.viewModel.popularTvShows[indexPath.row];
    [cell addShimmerEffect];
    
    [self.viewModel loadImageForTvShows:tvShow completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        
        if (error) {
            // TODO: Make error view
        }
        
        if (image) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cell.moviePoster.image = image;
                cell.movieTitle.text = tvShow.name;
                cell.movieDescriptionLabel.text = tvShow.overview.length == 0 ? @"No description" : tvShow.overview ;
                cell.moviePopularityLabel.text = [NSString stringWithFormat:@"★ %@",tvShow.vote_average];
                cell.movieReleaseDateLabel.text = [self.viewModel getDateCorrectFormat:tvShow.first_air_date];
                [cell removeShimmerEffect];
            });
           
        }
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TvShowsPopularModel *selectedTvShow = self.viewModel.popularTvShows[indexPath.row];
    DetailShowViewController *detailView = [[DetailShowViewController alloc] init];
    detailView.selectedShow = selectedTvShow;
    [self.navigationController pushViewController:detailView animated:YES];
}


#pragma mark: - Collection view flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(175, 350);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 7;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(16, 4, 0, 4);
}

@end
