//
//  BaseVC.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2017/11/6.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "BaseVC.h"
#import "WKCircleSpreadAnimator.h"
#import "WKExpandAnimator.h"
#import "WKFilpToonAnimator.h"
#import "WKWindowedModelAnimator.h"
#import "UIViewController+WKTransitions.h"
#import "UINavigationController+WKTransitions.h"
@interface BaseVC ()

@property (nonatomic, strong) UIButton * backBtn;
@property (nonatomic, strong) UIButton * goBtn;
@end

@implementation BaseVC

- (instancetype)init
{
    if (self =[super init]) {
        NSUInteger index = rand() % 3;
        WKBaseAnimator * animator = nil;
        switch (index) {
            case 0:
            {
                WKCircleSpreadAnimator * csa = [WKCircleSpreadAnimator new];
                csa.circleFrame = CGRectMake(100, 20, 80, 80);
                animator = csa;
            }
                break;
            case 2:
            {
                WKExpandAnimator * exp = [WKExpandAnimator new];
                exp.viewFrame = CGRectMake(0, 200, SCREEN_WIDTH, 80);
                exp.moveViewNewTop = 0;
                animator = exp;

            }
                break;
            case 1:
            {
                WKFilpToonAnimator * fta = [WKFilpToonAnimator new];
                animator = fta;
            }
                break;
//
//            default:
////            {
////                WKWindowedModelAnimator * wm = [WKWindowedModelAnimator new];
////                wm.toViewHeight = self.goBtn.bottom + 50;
////                animator = wm;
////            }
//                break;
        }
        self.wk_navAnimator = animator;
        self.wk_modelAnimator = animator;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模态";
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.goBtn];
    
    CGFloat red = random() % 256;
    CGFloat green = random() % 256;
    CGFloat blue = random() % 256;
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];

    
    [self.view setBackgroundColor:color];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.backgroundColor = [UIColor redColor];
        [_backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.frame = CGRectMake(40, 80, SCREEN_WIDTH - 40 * 2, 80);
    }
    return _backBtn;
}

- (UIButton *)goBtn
{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _goBtn.backgroundColor = [UIColor redColor];
        [_goBtn setTitle:@"前进" forState:(UIControlStateNormal)];
        [_goBtn addTarget:self action:@selector(go) forControlEvents:(UIControlEventTouchUpInside)];
        _goBtn.frame = CGRectMake(40, self.backBtn.bottom + 20, SCREEN_WIDTH - 40 * 2, 80);

    }
    return _goBtn;
}

- (void)back
{
    if(self.navigationController)
    {
        if (self.navigationController.viewControllers.count <= 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)go
{
    BaseVC * vc = [BaseVC new];
    if(self.navigationController)
    {
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self presentViewController:vc animated:YES completion:nil];
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

@end
