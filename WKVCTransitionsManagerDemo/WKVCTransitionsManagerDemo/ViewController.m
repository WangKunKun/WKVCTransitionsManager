//
//  ViewController.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2017/11/6.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "UIViewExt.h"
#import "MagicMoveCell.h"
#import "MagicMoveVC.h"
#import "WindowModelVC.h"
#import "UINavigationController+WKTransitions.h"
#import "UIViewController+WKTransitions.h"
#import "MagicMoveTransition.h"
#import "WKCircleSpreadAnimator.h"
#import "WKExpandAnimator.h"
#import "WKWindowedModelAnimator.h"
#import "WKAnimatorManager.h"
#import "CircleVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIButton * bottomBtn;
@property (nonatomic, strong) UIButton * circleBtn;

@property (nonatomic, strong) NSMutableArray * datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.circleBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)circleClick
{
    CircleVC * vc = [CircleVC new];
    WKCircleSpreadAnimator * animator = [WKCircleSpreadAnimator new];
    animator.circleFrame = self.circleBtn.frame;
    vc.wk_navAnimator = animator;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoWindoeModelVC
{
    WindowModelVC * vc = [WindowModelVC new];
    WKWindowedModelAnimator * animator = [WKWindowedModelAnimator new];
    animator.toViewHeight = SCREEN_HEIGHT / 2.f;
//    vc.wk_modelAnimator = animator;
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
//都可以啊
    vc.wk_navAnimator = animator;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MagicMoveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MagicMoveCell"];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MagicMoveVC * vc = [MagicMoveVC new];
    MagicMoveTransition * transition = [MagicMoveTransition new];
    transition.maxProgress = 0.25;
    transition.sourceView = [(MagicMoveCell *)[tableView cellForRowAtIndexPath:indexPath] IV];
    transition.endRect = [vc IVFrame];
    vc.wk_navAnimator = transition;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = SCREEN_WIDTH / 2.f;
        [_tableView registerClass:[MagicMoveCell class] forCellReuseIdentifier:@"MagicMoveCell"];
    }
    return _tableView;
}

- (UIView *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT - TAB_BAR_HEIGHT), SCREEN_WIDTH, TAB_BAR_HEIGHT)];
        _bottomBtn.backgroundColor = [UIColor whiteColor];
        [_bottomBtn setTitle:@"窗口模式" forState:(UIControlStateNormal)];
        [_bottomBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_bottomBtn addTarget:self action:@selector(gotoWindoeModelVC) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _bottomBtn;
}

- (UIButton *)circleBtn
{
    if (!_circleBtn) {
        _circleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_circleBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
        _circleBtn.frame = CGRectMake(SCREEN_WIDTH - 62 - 20, SCREEN_HEIGHT - TAB_BAR_HEIGHT - 100, 62, 62);
        [_circleBtn addTarget:self action:@selector(circleClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _circleBtn;
}

@end
