//
//  WindowModelVC.m
//  WKVCTransitionsManagerDemo
//
//  Created by wangkun on 2018/12/17.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "WindowModelVC.h"
#import "UIViewExt.h"
@interface WindowModelVC ()

@end

@implementation WindowModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    label.textColor = [UIColor purpleColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
    label.text = @"窗口模式";
    label.textAlignment = NSTextAlignmentCenter;

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
