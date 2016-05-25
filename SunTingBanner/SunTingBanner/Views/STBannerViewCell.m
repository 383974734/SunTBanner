//
//  STBannerViewCell.m
//  SunTingBanner
//
//  Created by yinduo-zdy on 16/5/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "STBannerViewCell.h"
#import <UIImageView+WebCache.h>

@interface STBannerViewCell ()

// ---------------------- UI 控件 ----------------------
/*! 显示 默认 图片轮播 的view */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation STBannerViewCell

/*!
 *  重写初始化方法 添加控件
 *
 *  @param  frame
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

/*!
 *  重写 layoutSubviews 方法 设置 控件的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

/*!
 *  添加控件
 */
- (void) addUI {
    [self.contentView addSubview:self.imageView];
}


/*!
 *  设置 显示的图片
 *
 *  @param imageName 图片 名称
 */
- (void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    [self settingData];
}


/*!
 *  设置数据
 */
- (void) settingData {
    
    if (self.isLoadNetworkImage) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageName] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    } else {
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
    
}

#pragma mark - UIInitMethod
- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}


@end
