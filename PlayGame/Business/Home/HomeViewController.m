//
//  HomeViewController.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "HomeViewController.h"

#define head @"oOrign"
#define oNa @"oNa"

@interface HomeViewController ()
@property (nonatomic, assign) NSInteger selectGame;
@property (nonatomic, assign) NSInteger selectSex;
@end

@implementation HomeViewController

- (void)addRightBtn{
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 40)];
    [right addTarget:self action:@selector(clickBegin) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"开始匹配" forState:UIControlStateNormal];
    right.titleLabel.font = [UIFont systemFontOfSize:14];
    [right setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.vwNavigation addSubview:right];
    right.centerY = self.vwNavigation.centerY + 10;
}
- (void)clickBegin{
    NSLog(@"开始匹配");
    if (self.selectGame == -1) {
        [self showHint:@"请选择想玩的游戏"];
    }else if(self.selectSex == -1){
        [self showHint:@"请选择玩家性别"];
    }else{
        [self showHint:@"玩家匹配中请稍后..."];
        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                         @"xb":@(self.selectSex),
                                         @"yx":@(self.selectGame)
        } url:@"/ping/mei/pp" callback:^(JTBaseReqModel *model) {
            if (model.zt == -2) {
                [self showHint:@"账号在其他设备登录"];
                [UserModelManager userLogout];
            }else{
                [self showHint:@"匹配成功请切换到消息页面"];
                NSArray* array = model.sj;
                for (NSDictionary* value in array) {
                    NSString* toID = [NSString stringWithFormat:@"%@",value[@"uid"]];
                    // 调用:
                    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:[NSString stringWithFormat:@"你好，请问你有空吗？"]];
                    // 获取当前登录的环信id
                    NSString *from = [[EMClient sharedClient] currentUsername];

                    //生成Message
                    EMMessage *message = [[EMMessage alloc] initWithConversationID:toID from:from to:toID body:body ext:nil];
                    message.ext = @{[NSString stringWithFormat:@"t%@alHead",head]:value[@"header"],
                                    [NSString stringWithFormat:@"t%@me",oNa]:value[@"nickname"]
                    };
                    message.chatType = EMChatTypeChat;// 设置为单聊消息
                    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                    } completion:^(EMMessage *message, EMError *error) {
                    }];
                }
            }
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"快速匹配玩家";
    self.selectGame = -1;
    self.selectSex = -1;
    [self addNavigationView];
    [self hiddenBackBtn:YES];
    [self addRightBtn];
    
}
- (void)loadUI{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"选择你想玩的游戏",
                                                         BM_title:@"chose",
                                                         BM_cellHeight:@(50),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_type:@(UIImageLabelSelectType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"英雄联盟",
                                                         BM_title:@"xlm",
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(-20),
                                                         BM_mark:self.selectGame == 1?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"王者荣耀",
                                                         BM_title:@"wzry",
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(-20),
                                                         BM_mark:self.selectGame == 2?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"绝地求生",
                                                         BM_title:@"jdqs",
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(-20),
                                                         BM_mark:self.selectGame == 3?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"吃鸡战场",
                                                         BM_title:@"cj",
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(-20),
                                                         BM_mark:self.selectGame == 4?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"小游戏",
                                                         BM_title:@"yx",
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(-20),
                                                         BM_mark:self.selectGame == 5?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"选择玩家性别",
                                                         BM_title:@"xingbie",
                                                         BM_cellHeight:@(50),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_type:@(UIImageLabelSelectType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"男生",
                                                         BM_title:@"男",
                                                         BM_cellHeight:@(50),
                                                         BM_mark:self.selectSex == 1?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"女生",
                                                         BM_title:@"女",
                                                         BM_cellHeight:@(50),
                                                         BM_mark:self.selectSex == 2?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* model = self.dataArray[indexPath.row];
    if([model.type  isEqual: @(UIImageLabelSelectType)]){
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        self.selectGame = 1;
    }else if (indexPath.row == 3) {
        self.selectGame = 2;
    }else if (indexPath.row == 5) {
        self.selectGame = 3;
    }else if (indexPath.row == 7) {
        self.selectGame = 4;
    }else if (indexPath.row == 9) {
        self.selectGame = 5;
    }else if (indexPath.row == 12) {
        self.selectSex = 1;
    }else if (indexPath.row == 14){
        self.selectSex = 2;
    }
    [self loadUI];
}
@end
