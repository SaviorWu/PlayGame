//
//  GiftPickVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import "GiftPickVC.h"
#import "GiftCell.h"
@interface GiftPickVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbBuyCount;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (nonatomic, strong) NSString* selectGiftId;
@end

@implementation GiftPickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    self.lbBuyCount.text = @"1";
    self.btnSend.layer.masksToBounds = YES;
    self.btnSend.layer.cornerRadius = 15.f;
    [self.collectionView registerNib:[UINib nibWithNibName:@"GiftCell" bundle:nil] forCellWithReuseIdentifier:@"GiftCell"];
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = layout;
//    self.collectionView.scrollEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    self.lbMoney.text = [UserModelManager shareInstance].userModel.money;
    
}
- (IBAction)clickBtnAdd:(id)sender {
    self.lbBuyCount.text = [NSString stringWithFormat:@"%d",([self.lbBuyCount.text intValue] + 1)];
}
- (IBAction)clickBtnMinus:(id)sender {
    if ([self.lbBuyCount.text intValue] > 1) {
        self.lbBuyCount.text = [NSString stringWithFormat:@"%d",([self.lbBuyCount.text intValue] - 1)];
    }
}
- (IBAction)clickSend:(id)sender {

    if (self.selectGiftId.length == 0) {
        [self showHint:@"请选择您要赠送的礼物"];
        return;
    }
    NSInteger giftPrice = 0;
    for (GiffModel* model in self.arrayGift) {
        if ([model.id isEqualToString:self.selectGiftId]) {
            giftPrice = [model.price intValue];
        }
    }
    [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,
                                     @"uid":self.godId,
                                     @"sum":self.lbBuyCount.text,
                                     @"money":[NSString stringWithFormat:@"%ld",([self.lbBuyCount.text intValue]*giftPrice)],
                                     @"gift_id":self.selectGiftId
    } url:@"/app/users/gift" callback:^(JTBaseReqModel *model) {
        if (model.code == 1) {
            [self showHint:@"赠送成功"];
        }else{
            [self showHint:@"赠送失败"];
        }
        
    }];
    [self tap];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayGift.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GiftCell  *typeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GiftCell" forIndexPath:indexPath];
    GiffModel* model = self.arrayGift[indexPath.row];
    [typeCell.giftImg setImage:[UIImage imageNamed:[model.img_path substringFromIndex:17]]];
//    [typeCell.giftImg LoadImage:model.img_path withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
//        
//    }];
    typeCell.giftMoney.text = model.price;
    typeCell.giftName.text = model.title;
    
    if ([self.selectGiftId isEqualToString:model.id]) {
        typeCell.backView.backgroundColor = [UIColor colorWithHex:0xFFAFCA];
    }else{
        typeCell.backView.backgroundColor = UIColor.clearColor;
    }
    return typeCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 16) / 4.00, 90.00);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    self.selectGiftId = self.arrayGift[indexPath.row].id;
    [self.collectionView reloadData];
}

@end
