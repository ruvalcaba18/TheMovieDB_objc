//
//  DetailShowViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailShowViewController.h"

@interface DetailShowViewController ()

@property (atomic, strong) DetailViewModel *viewModel;
@property (nonatomic,strong) NSArray *castArray;

-(void)setupView;
-(void)configureUI;
- (void)updateLabels;

@end

@implementation DetailShowViewController
@synthesize selectedShow,posterImageView,descriptionContainerView,castContainerView,castCollectionView,selectedOption,viewModel,titleLabel,popularityCircleView,creatorLabel,descriptionLabel,castArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[DetailViewModel alloc] initDetailViewModel];
    self.castArray = [NSArray array];
    
    [self setupView];
    
    [self.viewModel fetchDetailsWithOption:self.selectedOption
                             andIdentifier:[self.selectedShow.identifier stringValue]];
    
    [NetworkManager.sharedManager loadImageForShow:self.selectedShow completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.posterImageView.image = image;
            });
        }
    }];
    
    [self.viewModel fetchCastForTvShowWithId: [self.selectedShow.identifier integerValue] completion:^(NSArray * _Nonnull cast, NSError * _Nonnull error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                          self.castArray = cast;
                          [self.castCollectionView reloadData];
                      });
        } else {
            NSLog(@"error in cast %@",error);
        }
    }];
    
    [self configureUI];
}

#pragma mark - Setup Methods

- (void)setupView {
    
    self.descriptionContainerView.layer.cornerRadius = 20;
    self.descriptionContainerView.clipsToBounds = YES;
    self.popularityCircleView.layer.cornerRadius = self.popularityCircleView.frame.size.width / 2.0;
    self.popularityCircleView.layer.masksToBounds = YES;
    self.castCollectionView.delegate = self;
    self.castCollectionView.dataSource = self;
    [self.castCollectionView registerNib: [UINib nibWithNibName:@"RoundedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier: RoundedCellIdentifier];
}

- (void)configureUI {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateLabels];
        
        [self.castCollectionView reloadData];
    });
}

- (void)updateLabels {
    
    if (self.selectedOption == searchTvShows) {
        self.titleLabel.text = self.viewModel.serieDetails.name;
        self.descriptionLabel.text = self.viewModel.serieDetails.overview;
        self.creatorLabel.text = [self.viewModel formattedCreators:self.viewModel.serieDetails.createdBy];
        self.popularityLabel.text = [NSString stringWithFormat:@"%@", [NSNumber roundToSingleDecimal:self.viewModel.serieDetails.voteAverage]];
    } else {
        self.titleLabel.text = self.viewModel.movieDetails.title;
        self.descriptionLabel.text = self.viewModel.movieDetails.overview;
        self.popularityLabel.text = [ [NSNumber roundToSingleDecimal:self.viewModel.movieDetails.voteAverage] stringValue];
    }
}


#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return castArray.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    RoundedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RoundedCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    Actor *actor = self.castArray[indexPath.row];
    
    cell.nameMemberLabel.text = actor.name ;

    [NetworkManager.sharedManager  loadImageForActor:actor completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
        
                cell.memberPhoto.image = image;
            });
        } else {
            NSLog(@"Error cargando imagen del actor: %@", error.localizedDescription);
        }
    }];

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return minimumLineSpacingForIndex;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return minimumSpacingForSection;
}


@end
