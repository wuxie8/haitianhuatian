//
//  HomePageViewController.m
//  haitianhuatian
//
//  Created by Admin on 2017/8/11.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HomePageViewController.h"
#import "WSPageView.h"
#import "WSIndexBanner.h"
#import "HomepageTableViewCell.h"
#import "productModel.h"
#import "ProductDetailsViewController.h"
#import "LoginViewController.h"
#import "UIImageView+AFNetworking.h"

#define pageHeight 160

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,WSPageViewDelegate,WSPageViewDataSource>
@property(strong, nonatomic)UIView *headView;
@property(strong, nonatomic)NSMutableArray *productMutableArray;

@end

@implementation HomePageViewController
{
    UITableView *homepageTable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    homepageTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49-20-44)];
    homepageTable.delegate=self;
    homepageTable.dataSource=self;
    homepageTable.tableHeaderView=self.headView;
    homepageTable.tableFooterView=[UIView new];
    [self.view addSubview:homepageTable];
    
    [self getData];
    // Do any additional setup after loading the view.
}
-(void)getData
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       appcode,@"code",
                       @"1.0.0",@"version",
                       @"1",@"page",
                       nil];
    NSArray *array=@[@"现金白条-你我贷",@"现金白条-随手贷",@"现金白条-保单贷",@"现金白条-供房贷",@"现金白条-税金贷",@"现金白条-学信贷"];

    [[NetWorkManager sharedManager]postNoTipJSON:loan parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr=responseObject[@"list"];
        if ([UtilTools isBlankString:responseObject[@"review"]]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"review"];
        }else
        {
            [[NSUserDefaults standardUserDefaults] setBool:[responseObject[@"review"]boolValue] forKey:@"review"];

        }
        if (![UtilTools isBlankArray:arr]) {
            for (int i=0; i<arr.count; i++) {
                NSDictionary *diction=arr[i];
                productModel *pro=[[productModel alloc]init];
               
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
                    pro.smeta=@"icon";
                    
                    int location=i%array.count;
                    pro.post_title=array[location];
                }
                else
                {
                    NSString *jsonString=diction[@"smeta"];
                    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&err];
                    pro.smeta=imagedic[@"thumb"];
                    pro.post_title=diction[@"post_title"];
                }

                pro.link=diction[@"link"];
                pro.edufanwei=diction[@"edufanwei"];
                pro.qixianfanwei=diction[@"qixianfanwei"];
                pro.shenqingtiaojian=diction[@"shenqingtiaojian"];
                pro.zuikuaifangkuan=diction[@"zuikuaifangkuan"];
                
                pro.post_hits=diction[@"post_hits"];
                pro.feilv=diction[@"feilv"];
                pro.productID=diction[@"id"];
                pro.post_excerpt=diction[@"post_excerpt"];
                NSArray *tags=diction[@"tags"];
                NSMutableArray *tagsArray=[NSMutableArray array];
                for (NSDictionary *dic in tags) {
                    [tagsArray addObject:dic[@"tag_name"]];
                }
                pro.tagsArray=tagsArray;
                pro.fv_unit=diction[@"fv_unit"];
                
                pro.qx_unit=diction[@"qx_unit"];
                
                [self.productMutableArray addObject:pro];

            }
            
        }
        
        [homepageTable reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
    
}

#pragma mark WSPageView

-(UIView *)headView
{
    if (!_headView) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, pageHeight)];
        _headView.backgroundColor=[UIColor redColor];
        WSPageView *pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,pageHeight)];
        pageView.delegate = self;
        pageView.dataSource = self;
        pageView.minimumPageAlpha = 0.4;   //非当前页的透明比例
        pageView.minimumPageScale = 0.85;  //非当前页的缩放比例
        pageView.orginPageCount = 1; //原始页数
        
        pageView.backgroundColor=[UIColor grayColor];
      
        [_headView addSubview:pageView];

    }
    return _headView;
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    return CGSizeMake(WIDTH, pageHeight);
}
#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return 1;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView) {
        
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0,  WIDTH , pageHeight)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView setImage:[UIImage imageNamed:@"Banner"]];
    return bannerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
#pragma mark  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    return self.productMutableArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    productModel *model=[self.productMutableArray objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cell";
    HomepageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[HomepageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
//    [cell.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,model.smeta]]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
        [cell.iconImageView setImage:[UIImage imageNamed:model.smeta]];
        
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,model.smeta]];
            UIImage * result;
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            result = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^
                          {
                              [cell.iconImageView  setImage:result];
                              
                          });
        });

    }
    cell.titleLabel.text=model.post_title;
    cell.detailLabel.text=model.post_excerpt;
    cell.post_hits_Label.text=model.post_hits;
    cell.feliv_Label.text=model.feilv;
    cell.interestrateLabel.text=[model.qx_unit isEqualToString:@"1"]?@"日利率":@"月利率" ;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        productModel *model=[self.productMutableArray objectAtIndex:indexPath.row];
        ProductDetailsViewController * productDetails=[ProductDetailsViewController new];
        productDetails.productModel=model;
        productDetails.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:productDetails animated:YES];
    }
    else{
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }

  

}
-(NSMutableArray *)productMutableArray
{
    if (!_productMutableArray) {
        _productMutableArray=[NSMutableArray array];
        
    }
    return _productMutableArray;
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
