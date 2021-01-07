//
//  OrderCommentVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "OrderCommentVC.h"

@interface OrderCommentVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UITextView *tvComment;
@property (weak, nonatomic) IBOutlet UILabel *lbTag;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (nonatomic, strong) NSString* getUserGiveStar;
@end

@implementation OrderCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviTitle = @"用户评价";
    [self addNavigationView];
    self.getUserGiveStar = @"1";
    self.imgHeader.layer.masksToBounds = YES;
    self.imgHeader.layer.cornerRadius = 8;
    [self.imgHeader LoadImage:self.userGameModel.header withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbNickName.text = self.userGameModel.nickname;
    self.tvComment.delegate = self;
    self.tvComment.layer.masksToBounds = YES;
    self.tvComment.layer.cornerRadius = 8;
    self.tvComment.layer.borderColor = [[UIColor colorWithHex:0xe0e0e0] CGColor];
    self.tvComment.layer.borderWidth = 1;
    
    self.btnSubmit.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
    self.btnSubmit.layer.masksToBounds = YES;
    self.btnSubmit.layer.cornerRadius =25;
    [self clickbtn1:nil];
}
- (IBAction)clickSubmit:(id)sender {
    if (self.tvComment.text.length < 4) {
        [self showHint:@"评价内容太短，请再说点吧"];
    }
    else if (self.tvComment.text.length > 100){
        [self showHint:@"评价太长了，长话短说吧～"];
    }
    else{
        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                         @"dd":self.orderID,
                                         @"bz":self.tvComment.text,
                                         @"xx":self.getUserGiveStar}
                                   url:@"/app/order/orderComtDo"
                              callback:^(JTBaseReqModel *model) {
            [self showHint:model.msg];
            if (model.code == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
        self.lbTag.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.lbTag.hidden = NO;
    }else{
        self.lbTag.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.lbTag.hidden = NO;
    }else{
        self.lbTag.hidden = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)clickbtn1:(id)sender {
    self.getUserGiveStar = @"1";
    [self.btn1 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn3 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn4 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn5 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
}
- (IBAction)clickbtn2:(id)sender {
    self.getUserGiveStar = @"2";
    [self.btn1 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn3 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn4 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn5 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
}
- (IBAction)clickbtn3:(id)sender {
    self.getUserGiveStar = @"3";
    [self.btn1 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn3 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn4 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
    [self.btn5 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
}
- (IBAction)clickbtn4:(id)sender {
    self.getUserGiveStar = @"4";
    [self.btn1 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn3 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn4 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn5 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_big"] forState:UIControlStateNormal];
}
- (IBAction)clickbtn5:(id)sender {
    self.getUserGiveStar = @"5";
    [self.btn1 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn2 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn3 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn4 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
    [self.btn5 setImage:[UIImage imageNamed:@"details_ic_getUserGiveStars_small_h"] forState:UIControlStateNormal];
}

@end
