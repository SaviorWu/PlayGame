//
//  HomePersonVC.m
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import "HomePersonVC.h"

@interface HomePersonVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbSexAge;
@property (weak, nonatomic) IBOutlet UILabel *lbAuth;
@property (weak, nonatomic) IBOutlet UILabel *lbFans;
@property (weak, nonatomic) IBOutlet UILabel *lbNick;
@property (weak, nonatomic) IBOutlet UILabel *lbID;
@property (nonatomic, strong) NSString* header;
@end

@implementation HomePersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _lbSexAge.layer.masksToBounds = YES;
    _lbSexAge.layer.cornerRadius = 8;
    _lbAuth.layer.masksToBounds = YES;
    _lbAuth.layer.cornerRadius = 8;
    [self setModel:self.uiModel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setModel:(UIBaseModel*)model
{
    self.header = model.imageName;
    [self.imgHeader LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbNickName.text = model.title;
    self.lbNick.text = model.title;
    self.lbSexAge.text = model.subTitle;
    self.lbSexAge.backgroundColor = model.subTitleColor;
    self.lbAuth.text = model.mark;
    self.lbFans.text = [NSString stringWithFormat:@"%@粉丝",model.dataArray[0]];
    self.lbID.text = model.dataArray[1];
}
- (IBAction)clickChat:(id)sender {
    [self tap];
    if (self.clickChat) {
        self.clickChat(@[self.lbID.text,self.lbNickName.text,self.header]);
    }
   
}
- (IBAction)clickGift:(id)sender {
    [self tap];
    if (self.clickGift) {
        self.clickGift(self.lbID);
    }
    
}
- (IBAction)clickHead:(id)sender {
    [self tap];
    if (self.clickHeader) {
        self.clickHeader(self.lbID.text);
    }
    
}

@end
