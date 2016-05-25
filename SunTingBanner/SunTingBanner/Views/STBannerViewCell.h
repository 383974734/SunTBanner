//
//  STBannerViewCell.h
//  SunTingBanner
//
//  Created by yinduo-zdy on 16/5/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STBannerViewCell : UICollectionViewCell

/*! 显示图片的名称     */
@property (nonatomic,   copy) NSString *imageName;
/** 是否 加载 远程 url */
@property (nonatomic, assign, getter=isLoadNetworkImage) BOOL loadNetworkImage;

/*!
 *  设置 显示的图片
 *
 *  @param imageName 图片 名称
 */
- (void)setImageName:(NSString *)imageName;

@end
