//
//  HomepageTableViewCell.h
//  haitianhuatian
//
//  Created by Admin on 2017/8/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomepageTableViewCell : UITableViewCell



@property(strong, nonatomic)UIImageView *iconImageView;


@property (nonatomic, copy) UILabel *titleLabel;

@property (nonatomic, copy) UILabel *detailLabel;

//申请人数
@property (nonatomic, copy) UILabel *post_hits_Label;

@property(strong, nonatomic)UILabel *interestrateLabel;
//利率
@property(strong, nonatomic)UILabel *feliv_Label;
@end
