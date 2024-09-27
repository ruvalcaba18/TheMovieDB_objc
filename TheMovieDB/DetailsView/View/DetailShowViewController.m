//
//  DetailShowViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailShowViewController.h"

@interface DetailShowViewController ()
@property (atomic, strong) DetailViewModel *viewModel;
-(void)setupContainerView;
-(void)setupCastCollectionView;
@end

@implementation DetailShowViewController
@synthesize selectedShow,showPosterImage,showContainerDescriptionView,castContainerView,castCollectionView,optionSelected,viewModel,titleLabel,circlePopularityView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupContainerView];
    [self setupCastCollectionView];
    [self.viewModel fetchDetailsWithOption:self.optionSelected andIdentifier: [self.selectedShow.identifier stringValue] ];
}

#pragma mark - Setup Methods

-(void)setupContainerView {
    
    self.showContainerDescriptionView.layer.cornerRadius = 20;
    self.showContainerDescriptionView.clipsToBounds = YES;
    self.viewModel = [[DetailViewModel alloc] initDetailViewModel];
    self.circlePopularityView.layer.cornerRadius = self.circlePopularityView.frame.size.width / 2.0;
    self.circlePopularityView.layer.masksToBounds = YES;
}

-(void)setupCastCollectionView {
    self.castCollectionView.delegate = self;
    self.castCollectionView.dataSource = self;
}

#pragma mark - Collection View Delegate and DataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}




@end
