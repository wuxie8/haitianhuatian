//
//  RegisterVC.m
//  jishi
//
//  Created by Admin on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "RegisterVC.h"

#define ViewHeight 40
#define ButtonWeight 100
@interface RegisterVC ()

@end

@implementation RegisterVC
{
    UIButton *but;
    NSArray *arr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"注册";
    self.view.backgroundColor=AppPageColor;
    UIImageView * image=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 24, WIDTH, ButtonWeight)];
    [image setImage:[UIImage imageNamed:@"LogonDisplaypage"]];
    image.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:image];
    arr=@[@"手机号",@"验证码"];
    NSArray *arr1=@[@"请输入手机号",@"请输入验证码"];
    for (int i=0; i<arr.count; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(image.frame)+ViewHeight+i*ViewHeight , WIDTH, ViewHeight)];
        view.backgroundColor=[UIColor whiteColor];
        view.tag=i+100;
        
//        [self.view addSubview:view];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        label.textColor=[UIColor blackColor];
        [label setText:arr[i]];
        [view addSubview:label];
        
        UITextField *text=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, WIDTH-CGRectGetMaxX(label.frame)-i*100/3, 40)];
        text.tag=1000+i;
        switch (i) {
            case 0:
            case 1:
                text.keyboardType=UIKeyboardTypeNumberPad;
                
                break;
                //               case 1:
                //                case 2:
                //                text.keyboardType=UIKeyboardTypeDefault;
                //                text.secureTextEntry=YES;
                //                break;
                
            default:
                break;
        }
        text.placeholder=arr1[i];
        //        text.delegate=self;
        [view addSubview:text];
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(5, 39, WIDTH-10, 1)];
        backView.backgroundColor=PageColor;
        [view addSubview:backView];
        if (i==arr.count-1) {
            but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-120, 0, 120, ViewHeight)];
            but.backgroundColor=AppButtonColor;
            [but setTitle:@"获取验证码" forState:UIControlStateNormal];
            [but addTarget: self action:@selector(verificationCodeRegister) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:but];
        }
        [self.view addSubview:view];
    }
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(image.frame)+ViewHeight+arr.count*ViewHeight+20, WIDTH-3*2, 50)];
    loginButton.backgroundColor=AppButtonColor;
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    loginButton.clipsToBounds=YES;
    [loginButton addTarget:self action:@selector(registerClick ) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius=5;
    [self.view addSubview:loginButton];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, CGRectGetMaxY(loginButton.frame), 200, 40)];
    label.text=@"注册即表示同意《及时雨注册协议》";
    label.font=[UIFont systemFontOfSize:12];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    // Do any additional setup after loading the view.
}

-(void)registerClick
{
 
    NSMutableDictionary *registerDic=[NSMutableDictionary dictionary];
    for (int i=0; i<arr.count; i++) {
        UIView *view1=[self.view viewWithTag:100+i];
        
        UITextField *text1=(UITextField *)[view1 viewWithTag:1000+i];
             [registerDic setObject:text1.text forKey:[NSString stringWithFormat:@"%d",i]];

    }
   
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                      registerDic[@"0"],@"mobile",
//                      registerDic[@"1"],@"password",
                       registerDic[@"1"],@"code",
                       appNo,@"no",

                       
                       nil];
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=register&a=bycode",SERVERE] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *resultDic=(NSDictionary *)responseObject;
        if ([resultDic[@"status"]boolValue]) {
            [MessageAlertView showSuccessMessage:@"注册成功"];
            User *user=[[User alloc]init];
            user.token=resultDic[@"token"];
            user.uid=resultDic[@"uid"];
            user.username=resultDic[@"username"];
            Context.currentUser=user;
            if ( [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")]) {
                //保存用户登录状态以及登录成功通知
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kIsLogin"];
                UIViewController *viewCtl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                
                [self.navigationController popToViewController:viewCtl animated:YES];
            }

        }else
        {
            [MessageAlertView showErrorMessage:[NSString stringWithFormat:@"%@",resultDic[@"info"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    
}
-(void)verificationCodeRegister
{
    UIView *view1=[self.view viewWithTag:100];
    
    UITextField *text1=(UITextField *)[view1 viewWithTag:1000];

    if (text1.text.length==0) {
        [MessageAlertView showErrorMessage:@"请输入手机号"];
        return;
    }
    else if (text1.text.length!=11)
    {
        [MessageAlertView showErrorMessage:@"请输入正确的手机号"];
        return;
    }
    
       __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [but setTitle:[NSString stringWithFormat:@"%ld秒",(long)second] forState:UIControlStateNormal];
                second--;
                [but setEnabled:NO];
                but.alpha=0.4;
                but.backgroundColor=[UIColor grayColor];
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [but setTitle:@"获取验证码" forState:UIControlStateNormal];
                [but setEnabled:YES];
                but.alpha=1;
                but.backgroundColor=AppButtonColor;
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       text1.text,@"mobile",
                       
                       nil];
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@%@",SERVERE,verificationCoderegister] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"status"]boolValue]) {
            [MessageAlertView showSuccessMessage:@"发送成功"];
                   }
        else
        {
            [MessageAlertView showErrorMessage:[NSString stringWithFormat:@"%@",responseObject[@"info"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          
        
    }];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
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
