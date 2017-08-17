//
//  HomepageTableViewCell.m
//  haitianhuatian
//
//  Created by Admin on 2017/8/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HomepageTableViewCell.h"
#define interval 10
@implementation HomepageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatHealthBroadcastCellUI];
    }
    return self;
}
-(void)creatHealthBroadcastCellUI
{
    
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
    //    _image.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    _iconImageView.image=[UIImage imageNamed:@"icon"];
    [self.contentView addSubview:_iconImageView];
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+interval, 20, WIDTH-CGRectGetMaxX(_iconImageView.frame), 25)];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.font= [UIFont boldSystemFontOfSize:16 ];
    [self.contentView addSubview:_titleLabel];
    _detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+interval , CGRectGetMaxY(_titleLabel.frame)+5, WIDTH-CGRectGetMaxX(_iconImageView.frame), 20  )];
    _detailLabel.font=[UIFont systemFontOfSize:14];
    [_detailLabel setTextColor:[UIColor grayColor]];
    _detailLabel.textAlignment=NSTextAlignmentLeft;
    
    
    [self.contentView addSubview:_detailLabel];
    
    UILabel *applicationsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame), WIDTH/2, 30)];
    applicationsLabel.text=@"申请人数";
    applicationsLabel.font=[UIFont systemFontOfSize:14];
    applicationsLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:applicationsLabel];
    
    
    _post_hits_Label=[[UILabel alloc]initWithFrame:CGRectMake(0 , CGRectGetMaxY(applicationsLabel.frame), WIDTH/2, 20  )];
    _post_hits_Label.font=[UIFont systemFontOfSize:14];
    [_post_hits_Label setTextColor:[UIColor redColor]];
    _post_hits_Label.textAlignment=NSTextAlignmentCenter;
    
    
    [self.contentView addSubview:_post_hits_Label];
    
    
   _interestrateLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(_detailLabel.frame), WIDTH/2, 30)];
    _interestrateLabel.font=[UIFont systemFontOfSize:14];

    _interestrateLabel.textAlignment=NSTextAlignmentCenter;

    [self.contentView addSubview:_interestrateLabel];
    _feliv_Label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2 ,CGRectGetMaxY(_interestrateLabel.frame), WIDTH/2, 20)];
    [_feliv_Label setTextColor:[UIColor redColor]];
    _feliv_Label.textAlignment=NSTextAlignmentCenter;
    _feliv_Label.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_feliv_Label];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
