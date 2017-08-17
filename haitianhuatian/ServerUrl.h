//
//  ServerUrl.h
//  haitianhuatian
//
//  Created by Admin on 2017/8/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#ifndef ServerUrl_h
#define ServerUrl_h

#define SERVERE @"http://app.jishiyu11.cn/index.php?g=app"

#define SERVEREURL SERVERE

#define UploadPath @"http://47.93.122.140:8001/index.php?g=app"

#define IMG_PATH  @"http://app.jishiyu11.cn/data/upload/"//品牌logo
//贷款
#define loan @"&m=business&a=index"
//换一批
#define exchange @"&m=business&a=change_list"
//登陆验证码
#define verificationCodeLogin  @"&m=login&a=send_code"
//注册验证码
#define verificationCoderegister  @"&m=register&a=send_code"
//注册
#define doregister  @"&m=register&a=doregister"
//无密码注册
#define bycode  @"&m=register&a=bycode"

#define USER_APPID           @"596d63d5"

//登陆
#define dologin  @"&m=login&a=dologin"
//重置密码
#define reset_password  @"&m=register&a=reset_password"
//贷款参数
#define filter_para @"&m=business&a=filter_para"

#define filter @"&m=business&a=filter"

//贷款
#define appcode @"xianjinbaitiao"

#define appNo @"QD0122"



#endif /* ServerUrl_h */
