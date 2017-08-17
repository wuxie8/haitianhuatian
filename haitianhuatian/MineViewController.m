//
//  MineViewController.m
//  haitianhuatian
//
//  Created by Admin on 2017/8/15.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "MineViewController.h"
#import "HelpCenterViewController.h"
#import "BusinessCooperationViewController.h"
#import "LoginViewController.h"
#import "AboutUsViewController.h"
#import "AddressVC.h"
#import "FeedbackViewController.h"
#define kMargin 10
static NSString *const cellId = @"cellId1";
static NSString *const headerId = @"headerId1";

@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *LoadcollectionView;

@end

@implementation MineViewController
{
    UIButton *headBut;
    NSArray *imageArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {

        [headBut setTitle:Context.currentUser.username forState:0];
        headBut.enabled=NO;
        [headBut setTitle:Context.currentUser.username forState:UIControlStateNormal];

    }
    else{
        [headBut setTitle:@"立即登录" forState:0];
        headBut.enabled=YES;

    }
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人中心";
    imageArray=@[@"InviteFriends",@"HelpCenter",@"registration",@"BusinessCooperation",@"About_us",@"LogOut"];
    _LoadcollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_LoadcollectionView setBackgroundColor:[UIColor whiteColor]];
    _LoadcollectionView.delegate = self;
    _LoadcollectionView.dataSource = self;
    // 注册cell、sectionHeader、sectionFooter
    [_LoadcollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_LoadcollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    self.LoadcollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_LoadcollectionView];    // Do any additional setup after loading the view.
}
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = AppPageColor;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.2*HEIGHT<130?130:0.2*HEIGHT)];
        imageView.image=[UIImage imageNamed:@"BackgroundPicture"];
        [headerView addSubview:imageView];
        
        UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-30, 20, 60, 60)];
        headImage.image=[UIImage imageNamed:@"HeadImage"];
        [headerView addSubview:headImage];

        headBut=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-100, CGRectGetMaxY(headImage.frame)+20, 200, 30)];
        headBut.titleLabel.textAlignment=NSTextAlignmentCenter;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
            [headBut setTitle:Context.currentUser.username forState:0];
            headBut.enabled=NO;
            
        }
        else{
            [headBut setTitle:@"立即登录" forState:0];
            headBut.enabled=YES;
            
        }
        [headBut addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:headBut];
        return headerView;

    }
    else{
        return nil;
    }
    
}
-(void)login{
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loginVC animated:YES];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[_LoadcollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    cell.backgroundView=[[UIImageView alloc]initWithImage:
//                         [UIImage imageNamed:[[imageArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage
                                                          imageNamed:imageArray[indexPath.row]]];
    //    [cell.imageView setImage:[UIImage imageNamed:[[arr4 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    //    [cell.titleLabel setText:[[arr2 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    //    [cell.detailLabel setText:[[arr3 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-kMargin*5)/3, (WIDTH-kMargin*4)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){WIDTH,0.2*HEIGHT};
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {

    switch (indexPath.row) {
        case 2:
        {

            FeedbackViewController *feedback=[FeedbackViewController new];
            feedback.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:feedback animated:YES];
           
        }
            break;
        case 1:
        {
            HelpCenterViewController *help=[HelpCenterViewController new];
            help.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:help animated:YES];

        }
            break;
        case 0:
        {
            AddressVC *adress=[[AddressVC alloc]init];
            adress.hidesBottomBarWhenPushed=YES;

            [self.navigationController pushViewController:adress animated:YES];

            
        }
            break;
        case 3:
        {
            BusinessCooperationViewController *business=[BusinessCooperationViewController new];
            business.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:business animated:YES];
            
        }
            break;
        case 4:
        {
           AboutUsViewController  *business=[AboutUsViewController new];
            business.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:business animated:YES];
            
        }
            break;
        case 5:
        {
            LoginViewController *loginVC=[[LoginViewController alloc]init];
            loginVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:loginVC animated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kIsLogin"];
            Context.currentUser = nil;
            //用户信息归档
            [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")];
            
        }
            break;
        default:
            break;
    }
    
    }
    else{
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    
    }
    
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
