//
//  MagicMoveVC.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2018/12/17.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "MagicMoveVC.h"
#import "UIViewExt.h"
@interface MagicMoveVC ()

@property (nonatomic, strong) UIImageView * IV;

@end

@implementation MagicMoveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.IV];
    self.IV.frame = [self IVFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Magic";
}

- (CGRect)IVFrame
{
    return CGRectMake(0, NAVIGATION_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH / 2.f);
}

- (UIImageView *)IV
{
    if (!_IV) {
        _IV = [UIImageView new];
        [_IV setImage:[UIImage imageNamed:@"magicmove"]];
    }
    return _IV;
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
