//
//  DetailShowViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailShowViewController.h"

@interface DetailShowViewController ()
@property (atomic, strong) DetailViewModel *viewModel;
-(void)setupView;
-(void)configureUI;
@end

@implementation DetailShowViewController
@synthesize selectedShow,posterImageView,descriptionContainerView,castContainerView,castCollectionView,selectedOption,viewModel,titleLabel,popularityCircleView,creatorLabel,descriptionLabel;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.viewModel = [[DetailViewModel alloc] initDetailViewModel];
    [self setupView];
    [self.viewModel fetchDetailsWithOption:self.selectedOption
                             andIdentifier:[self.selectedShow.identifier stringValue]];
    
    [self configureUI];
}

#pragma mark - Setup Methods

- (void)setupView {
    
    self.descriptionContainerView.layer.cornerRadius = 20;
    self.descriptionContainerView.clipsToBounds = YES;
    self.popularityCircleView.layer.cornerRadius = self.popularityCircleView.frame.size.width / 2.0;
    self.popularityCircleView.layer.masksToBounds = YES;
}

- (void)setupCastCollectionView {
    
    self.castCollectionView.delegate = self;
    self.castCollectionView.dataSource = self;
    [self.castCollectionView registerNib:[UINib nibWithNibName:@"RoundedCollectionViewCell" bundle:nil]
              forCellWithReuseIdentifier:RoundedCellIdentifier];
}

- (void)configureUI {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self updateLabels];
        
    });
}

- (void)updateLabels {
    
    if (self.selectedOption == searchTvShows) {
        
        self.titleLabel.text = self.viewModel.serieDetails.name;
        self.descriptionLabel.text = self.viewModel.serieDetails.overview;
        self.creatorLabel.text = [self.viewModel formattedCreators: self.viewModel.serieDetails.createdBy ];
        self.popularityLabel.text =  [NSString stringWithFormat:@"%@", [self.viewModel roundToSingleDecimal: self.viewModel.serieDetails.voteAverage] ];
        
    } else {
        
        self.titleLabel.text = self.viewModel.movieDetails.title;
        self.descriptionLabel.text = self.viewModel.movieDetails.overview;
        self.popularityLabel.text = [ [self.viewModel roundToSingleDecimal: self.viewModel.movieDetails.voteAverage ] stringValue];
    }
}



#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RoundedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RoundedCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 23;
}


@end
