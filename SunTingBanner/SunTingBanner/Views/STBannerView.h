//
//  STBannerView.h
//  SunTingBanner
//
//  Created by yinduo-zdy on 16/5/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  轮播

#import <UIKit/UIKit.h>

@class STBannerView;
/*! stBannerView 数据源协议  */
@protocol StBannerViewDataSource <NSObject>

/*!
 *  stBannerView 数据源方法 (设置 stBannerView 每个分组显示数据的个数)
 *
 *  @param  stBannerView
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger)  stBannerView:(STBannerView *)stBannerView numberOfItemsInSection:(NSInteger)section;


/*!
 *  stBannerView 数据源方法 (设置 stBannerView 显示默认的cell 显示图片的名称)
 *
 *  (注意: stCustomCell 值 为 NO 时 才会调用， stCustomCell 默认为 NO)
 *
 *  @param  stBannerView
 *  @param  indexPath
 *
 *  @return NSString
 */
- (NSString *) stBannerView:(STBannerView *)stBannerView cellTitleForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/*!
 *  stBannerView 数据源方法 (设置 stBannerView 分组的 个数)
 *
 *  @param  stBannerView
 *
 *  @return NSInteger
 */
- (NSInteger) stBannerViewNmberOfSections:(STBannerView *)stBannerView;

/*!
 *  stBannerView 数据源方法 (设置 stBannerView 自定义cell 的样式 和 显示的数据)
 *
 *  (注意: stCustomCell 值 为 YES 时 才会调用， stCustomCell 默认为 YES)
 *
 *  @param  stBannerView
 *  @param  collectionView
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 */
- (UICollectionViewCell  *) stBannerView:(STBannerView *)stBannerView collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;


@end
/*! stBannerView 代理协议 */
@protocol STBannerViewDelegate <NSObject>

@optional

/*!
 *  STBannerView 代理方法 (点击 STBannerView 每个cell调用代理方法)
 *
 *  @param STBannerView
 *  @param indexPath
 */
- (void) stBannerView:(STBannerView *)stBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/*!
 *  STBannerView 代理方法 (设置 STBannerView 每个cell的宽高)
 *
 *  @param  STBannerView
 *  @param  collectionView
 *  @param  collectionViewLayout
 *  @param  indexPath
 *
 *  @return CGSize
 */
- (CGSize) stBannerView:(STBannerView *)stBannerView collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;



@end

@interface STBannerView : UIView

/*! 设置 stBanner 数据源属性                          */
@property (nonatomic, assign) id<StBannerViewDataSource> dataSource;
/*! 设置 stBanner 代理属性                            */
@property (nonatomic, assign)  id<STBannerViewDelegate> delegate;
/*! 设置 stBanner 定时 时间                           */
@property (nonatomic, assign)  CGFloat stBannerTime;
/*! 设置 stBanner 是否自定义cell  默认 NO             */
@property (nonatomic, assign, getter = isStBannerCustomCell)        BOOL stBannerCustomCell;
/*! 设置 stBanner 是否加载 远程url 图片 默认是 YES    */
@property (nonatomic, assign, getter = isStBannerLoadNetworkImage)  BOOL stBannerLoadNetworkImage;
/*! 设置 stBanner 是否 开启 弹簧效果 默认是 YES       */
@property (nonatomic, assign, getter = isStBannerBounces)           BOOL stBannerBounces;
/*! 设置 stBanner 中 PagesColor 是否 隐藏 默认 是 NO  */
@property (nonatomic, assign, getter = isStBannerPageControlHidden) BOOL stBannerPageControlHidden;
/*! 设置 stBanner 中 stPageBackgroundVeiw 是否 隐藏 默认 是 NO  */
@property (nonatomic, assign, getter=isPageBackgroundVeiwHidden)    BOOL stPageBackgroundVeiwHidden;
/*! 设置 stBanner 中 PagesColor 总页数的颜色          */
@property (nonatomic, strong) UIColor *numberOfPagesColor;
/*! 设置 stBanner 中 PagesColor 当前页数的颜色        */
@property (nonatomic, strong) UIColor *currentPageColor;


/*!
 *  设置 stBanner       定时 时间
 *
 *  @param stBannerTime 定时时间
 */
- (void) setStBannerTime:(CGFloat)stBannerTime;

/*!
 *  设置 stBanner 是否自定义cell  默认 NO
 *
 *  @param stBannerCustomCell     YES 自定义, NO 使用默认
 */
- (void)setStBannerCustomCell:(BOOL)stBannerCustomCell;

/*!
 *  设置 stBanner 是否加载 远程url 图片 默认是 YES
 *
 *  @param stBannerLoadNetworkImage  YES 加载远程 url, NO 加载本地图片
 */
- (void)setStBannerLoadNetworkImage:(BOOL)stBannerLoadNetworkImage;

/*!
 *  设置 stBanner 是否 开启 弹簧效果 默认是 YES
 *
 *  @param stBannerBounces  YES 开启, NO 关闭
 */
- (void)setStBannerBounces:(BOOL)stBannerBounces;

/*!
 *  设置 stBanner 中 PagesColor 是否 隐藏 默认 是 NO
 *
 *  @param stBannerPageControlHidden YES 隐藏, NO 显示
 */
- (void)setStBannerPageControlHidden:(BOOL)stBannerPageControlHidden;

/*!
 *  设置 stBanner 中 stPageBackgroundVeiw 是否 隐藏 默认 是 NO
 *
 *  @param stPageBackgroundVeiwHidden YES 隐藏, NO 显示
 */
- (void) setStPageBackgroundVeiwHidden:(BOOL)stPageBackgroundVeiwHidden;

/*!
 *  设置 stBanner 中 PagesColor 总页数的颜色
 *
 *  @param numberOfPagesColor    颜色
 */
- (void)setNumberOfPagesColor:(UIColor *)numberOfPagesColor;

/*!
 *  设置 stBanner 中 PagesColor 当前页数的颜色
 *
 *  @param currentPageColor      颜色
 */
- (void)setCurrentPageColor:(UIColor *)currentPageColor;

/*!
 *  stBanner 注册一个cell
 *
 *  @param cellClass        注册 一个cell的类名
 *  @param identifier       cell ID (唯一标识)
 */
- (void) stBannerRegisterClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
/*!
 *  StBannerView 数据刷新
 */
- (void) stBannerReloadData;


@end
