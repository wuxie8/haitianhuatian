//
//  BusinessCooperationViewController.m
//  haitianhuatian
//
//  Created by Admin on 2017/8/15.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BusinessCooperationViewController.h"

@interface BusinessCooperationViewController ()

@end

@implementation BusinessCooperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商务合作";
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-200, 250, 400, 100)];
    label.text=@"公司邮箱：bd@jishiyu11.cn";
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
