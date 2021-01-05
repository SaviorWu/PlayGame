//
//  ChatTopView.m
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import "ChatTopView.h"
#import "MLHeadCell.h"
@implementation ChatTopView

- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrayData = array;
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = UIColor.whiteColor;
        [self.collectionView registerNib:[UINib nibWithNibName:@"MLHeadCell" bundle:nil] forCellWithReuseIdentifier:@"MLHeadCell"];
        [self addSubview:self.collectionView];
        [self.collectionView reloadData];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MLModel* model = [self.arrayData objectAtIndex:indexPath.row];
    MLHeadCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MLHeadCell" forIndexPath:indexPath];
    [cell setModel:model];
    cell.block = ^{
        if (self.playSongBlock) {
            self.playSongBlock(model.path);
        }
    };
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.height, self.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MLModel* model = [self.arrayData objectAtIndex:indexPath.row];
    if (self.selectUserBlock) {
        self.selectUserBlock(model.to_uid);
    }
}

@end
