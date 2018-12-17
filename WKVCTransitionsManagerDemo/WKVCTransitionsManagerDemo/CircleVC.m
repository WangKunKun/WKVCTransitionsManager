//
//  CircleVC.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2018/12/17.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "CircleVC.h"
#import "UIViewExt.h"
@interface CircleVC ()

@property (nonatomic, strong) UIImageView * IV;

@end

@implementation CircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.IV];
    self.IV.frame = CGRectMake(0, NAVIGATION_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_STATUS_HEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Circle";

}

- (UIImageView *)IV
{
    if (!_IV) {
        _IV = [UIImageView new];
        [_IV setImage:[UIImage imageNamed:@"cover"]];
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
