//
//  TZAssetCell.m
//  TZImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "TZAssetCell.h"
#import "TZAssetModel.h"
#import "UIView+Layout.h"
#import "TZImageManager.h"
#import "TZImagePickerController.h"
@interface TZAssetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;       // The photo / 照片
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;
@property (nonatomic, strong) UIButton    *photoButton;

@end

@implementation TZAssetCell

- (void)awakeFromNib {
    self.timeLength.font = [UIFont boldSystemFontOfSize:11];
    [super awakeFromNib];
}

- (void)setModel:(TZAssetModel *)model {
    _model = model;
    if ([model.asset isKindOfClass:[UIImage class]]) {
        
        if(model.type==TZAssetModelMediaTypeVideo)
        {
            _selectImageView.hidden = YES;
            _selectPhotoButton.hidden = YES;
            _bottomView.hidden = YES;        }
        else
        {        self.type = TZAssetCellTypePhoto;

        }
        self.imageView.image=model.asset;
        self.selectPhotoButton.selected = model.isSelected;
        self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@"Selected"] : [UIImage imageNamed:@"Unselected"];
        
        
        
    }
    else{
        [[TZImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.width completion:^(UIImage *photo, NSDictionary *info) {
            self.imageView.image = photo;
        }];
        self.selectPhotoButton.selected = model.isSelected;
        self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@"Selected"] : [UIImage imageNamed:@"Unselected"];
        self.type = TZAssetCellTypePhoto;
        if (model.type == TZAssetModelMediaTypeLivePhoto)      self.type = TZAssetCellTypeLivePhoto;
        else if (model.type == TZAssetModelMediaTypeAudio)     self.type = TZAssetCellTypeAudio;
        else if (model.type == TZAssetModelMediaTypeVideo) {
            self.type = TZAssetCellTypeVideo;
            self.timeLength.text = model.timeLength;
        }
    }
}

- (void)setType:(TZAssetCellType)type {
    _type = type;
    if (type == TZAssetCellTypePhoto || type == TZAssetCellTypeLivePhoto) {
        _selectImageView.hidden = NO;
        _selectPhotoButton.hidden = NO;
        _bottomView.hidden = YES;
    } else {
        _selectImageView.hidden = YES;
        _selectPhotoButton.hidden = YES;
        _bottomView.hidden = NO;
    }
}

- (IBAction)selectPhotoButtonClick:(UIButton *)sender {
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectImageView.image = sender.isSelected ? [UIImage imageNamed:@"Selected"] : [UIImage imageNamed:@"Unselected"];
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:TZOscillatoryAnimationToBigger];
    }
}

@end

@interface TZAlbumCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end

@implementation TZAlbumCell

- (void)awakeFromNib {
    self.posterImageView.clipsToBounds = YES;
      [super awakeFromNib];
}

- (void)setModel:(TZAlbumModel *)model {
    _model = model;
    
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"  (%zd)",model.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [nameString appendAttributedString:countString];
    self.titleLable.attributedText = nameString;
    [[TZImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
        self.posterImageView.image = postImage;
    }];
}

/// For fitting iOS6
- (void)layoutSubviews {
    if (iOS7Later) [super layoutSubviews];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    if (iOS7Later) [super layoutSublayersOfLayer:layer];
}


@end
