//
//  MessageViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageListCell.h"
#import "EMRealtimeSearch.h"
#import "EMChatViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* arrayList;
@property (nonatomic) BOOL isViewAppear;
@property (nonatomic) BOOL isNeedReload;
@property (nonatomic) BOOL isNeedReloadSorted;
@end

@implementation MessageViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isViewAppear = NO;
    self.isNeedReload = NO;
    self.isNeedReloadSorted = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isViewAppear = YES;
    if (self.isNeedReloadSorted) {
        self.isNeedReloadSorted = NO;
        [self _loadAllConversationsFromDBWithIsShowHud:NO];

    } else if (self.isNeedReload) {
        self.isNeedReload = NO;
        [self.tableView reloadData];
    }
    [self _loadAllConversationsFromDBWithIsShowHud:NO];
    [self.tableView reloadData];
}
- (void)dealloc{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviTitle = @"消息";
    [self addNavigationView];
    [self hiddenBackBtn:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registCell:@"MessageListCell"];
    self.arrayList = [[NSMutableArray alloc] init];
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self _loadAllConversationsFromDBWithIsShowHud:YES];
    
}
- (void)_reSortedConversationModelsAndReloadView
{
    NSArray *sorted = [self.arrayList sortedArrayUsingComparator:^(EMConversationModel *obj1, EMConversationModel *obj2) {
        EMMessage *message1 = [obj1.emModel latestMessage];
        EMMessage *message2 = [obj2.emModel latestMessage];
        obj1.emModel.ext = message1.ext;
        obj2.emModel.ext = message2.ext;
        if(message1.timestamp > message2.timestamp) {
            return(NSComparisonResult)NSOrderedAscending;
        } else {
            return(NSComparisonResult)NSOrderedDescending;
        }}];
    
    if (sorted.count == 1) {
        EMConversationModel * cv = sorted[0];
        EMMessage *message1 = [cv.emModel latestMessage];
        cv.emModel.ext = message1.ext;
    }
    NSMutableArray *conversationModels = [NSMutableArray array];
    for (EMConversationModel *model in sorted) {
        if (!model.emModel.latestMessage) {
            [EMClient.sharedClient.chatManager deleteConversation:model.emModel.conversationId
                                                 isDeleteMessages:NO
                                                       completion:nil];
            continue;
        }
        
        [conversationModels addObject:model];
    }

    [self.arrayList removeAllObjects];
    [self.arrayList addObjectsFromArray:conversationModels];
    [self.tableView reloadData];

    self.isNeedReload = NO;
}
- (void)_loadAllConversationsFromDBWithIsShowHud:(BOOL)aIsShowHUD
{
    if (aIsShowHUD) {
        [self showHint:@"加载会话列表..."];
    }

    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        NSArray *sorted = [conversations sortedArrayUsingComparator:^(EMConversation *obj1, EMConversation *obj2) {
            EMMessage *message1 = [obj1 latestMessage];
            EMMessage *message2 = [obj2 latestMessage];
            obj1.ext = message1.ext;
            obj2.ext = message2.ext;
            if(message1.timestamp > message2.timestamp) {
                return(NSComparisonResult)NSOrderedAscending;
            } else {
                return(NSComparisonResult)NSOrderedDescending;
            }}];
        if (sorted.count == 1) {
            EMConversation * cv = sorted[0];
            EMMessage *message1 = [cv latestMessage];
            cv.ext = message1.ext;
        }
        
        [weakself.arrayList removeAllObjects];

        NSArray *models = [EMConversationHelper modelsFromEMConversations:sorted];
        
        [weakself.arrayList addObjectsFromArray:models];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (aIsShowHUD) {
                [weakself hideAllHud];
            }

            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView reloadData];
            weakself.isNeedReload = NO;
        });
    });
}
#pragma mark - EMChatManagerDelegate

- (void)messagesDidRecall:(NSArray *)aMessages {
    [self _loadAllConversationsFromDBWithIsShowHud:NO];
}

- (void)conversationListDidUpdate:(NSArray *)aConversationList
{
    if (!self.isViewAppear) {
        self.isNeedReloadSorted = YES;
    } else {
        [self _loadAllConversationsFromDBWithIsShowHud:NO];
    }
}

- (void)messagesDidReceive:(NSArray *)aMessages
{
    if (self.isViewAppear) {
        if (!self.isNeedReload) {
            self.isNeedReload = YES;
            [self performSelector:@selector(_reSortedConversationModelsAndReloadView) withObject:nil afterDelay:0.8];
        }
    } else {
        self.isNeedReload = YES;
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
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.arrayList[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EMConversationModel *model = self.arrayList[indexPath.row];
    NSString* nickname = @"";
    NSString* header = @"";
    NSString* chartUid = @"";
    if (model.emModel.latestMessage.direction == EMMessageDirectionReceive) {
        header = model.emModel.ext[@"fromOriginalHead"];
        nickname = model.emModel.ext[@"fromName"];
        chartUid = model.emModel.latestMessage.from;
    }else{
        header = model.emModel.ext[@"toOrignalHead"];
        nickname = model.emModel.ext[@"toName"];
        chartUid = model.emModel.latestMessage.to;
    }
    [self showHudInView:self.view];
    NSLog(@"chartUid = %@",chartUid);
    [JTNetwork requestGetWithParam:@{@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/ping/mei/ds" callback:^(JTBaseReqModel *baseModel) {
        [self hideAllHudFromSuperView:self.view];
        if (baseModel.zt == -2) {
                    [self showHint:@"账号在其他设备登录"];
                    [UserModelManager userLogout];
        }else{
            NSString* gameID = @"";
            if ([[baseModel.sj allKeys] containsObject:@"id"]) {
                gameID = [NSString stringWithFormat:@"%@",baseModel.sj[@"id"]];
            }
            if (gameID.length == 0) {
                return;
            }
            
            EMChatViewController *vc = [[EMChatViewController alloc] initWithCoversationModel:self.arrayList[indexPath.row]];
            vc.vcTitle = nickname.length == 0?@" ":nickname;
            vc.direction = (NSInteger)model.emModel.latestMessage.direction;
            vc.header = header;
            vc.gameID = gameID;
            vc.godID = chartUid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}
@end
