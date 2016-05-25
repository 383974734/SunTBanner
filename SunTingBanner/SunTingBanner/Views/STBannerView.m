//
//  STBannerView.m
//  SunTingBanner
//
//  Created by yinduo-zdy on 16/5/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  轮播
//  注意 :
//       1.STBannerView 内部实现使用的是 collectionView
//         如需要自定义 cell 需要 注册 cell 方法已经提供
//       2.STBannerView 图片轮播远程加载图片依赖 SDWebImage 三方库
//
//   构建时间: 2016年05月23日11:25:12
//   版本 1.0.1

#import "STBannerView.h"

// ---------------------- view       ----------------------
#import "STBannerViewCell.h"
// ---------------------- view       ----------------------

#define PAGE_HEIGHT 20.0

#define SIDTH (self.frame.size.width - 80)

static NSString *const stBannerCellID = @"stBannerCellID";


@interface STBannerView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>


// ---------------------- UI 控件 ----------------------
/*! 显示图片的 view                   */
@property (nonatomic, strong) UICollectionView *stBannerView;
/*! 显示图片分页的view                */
@property (nonatomic, strong) UIPageControl    *stBannerPageControlView;
/*! 记录 UICollectionView 的 section  */
@property (nonatomic, assign) NSInteger        section;
/*! 显示图片分页的区分线                */
@property (nonatomic, strong) UIButton         *stBannerPageBtn;
/*! 显示图片分页的区分线背景                */
@property (nonatomic, strong) UIView           *stPageBackgroundVeiw;
@end

@implementation STBannerView

/*!
 *  重写初始化方法 添加控件
 *
 *  @return STBannerView
 */
- (instancetype)init {
    
    if (self = [super init]) {
        [self addUI];
        [self initData];
    }
    return self;
}

/*!
 *  重写 layoutSubviews 方法 设置 控件的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.stBannerView.frame             = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.stBannerPageControlView.frame  = CGRectMake(0, self.frame.size.height - PAGE_HEIGHT, self.frame.size.width, PAGE_HEIGHT);
    self.stPageBackgroundVeiw.frame     = CGRectMake(40, self.frame.size.height - PAGE_HEIGHT, self.frame.size.width - 80, 1);

}

/*!
 *  初始化数据
 */
- (void) initData {
    self.stBannerCustomCell         = NO;
    self.stBannerLoadNetworkImage   = YES;
    self.stBannerBounces            = YES;
    self.stBannerPageControlHidden  = NO;
    self.stPageBackgroundVeiwHidden = NO;
    
    // 设置 pageControlView 总页数
    self.stBannerPageControlView.numberOfPages = [self.dataSource stBannerView:self numberOfItemsInSection:self.section];
    NSLog(@"看看是几%ld", (long)[self.dataSource stBannerView:self numberOfItemsInSection:self.section]);
    // 设置 pageControlView 当前也数
    self.stBannerPageControlView.currentPage   = 0;

    
}

/*!
 *  添加控件
 */
- (void) addUI {
    [self addSubview:self.stBannerView];
    [self addSubview:self.stBannerPageControlView];
    [self addSubview:self.stPageBackgroundVeiw];
    [self.stPageBackgroundVeiw addSubview:self.stBannerPageBtn];
}

#pragma mark - Setting StBannerView Propertys
/*!
 *  设置 stBanner定时 时间
 *
 *  @param stBannerTime 定时时间
 */
- (void) setStBannerTime:(CGFloat)stBannerTime {
    _stBannerTime = stBannerTime;
}

/*!
 *  设置 stBanner 是否自定义cell  默s认 NO
 *
 *  @param stBannerCustomCell     YES 自定义, NO 使用默认
 */
- (void) setStBannerCustomCell:(BOOL)stBannerCustomCell {
    _stBannerCustomCell = stBannerCustomCell;
}

/*!
 *  设置 stBanner 是否加载 远程url 图片 默认是 YES
 *
 *  @param stBannerLoadNetworkImage  YES 加载远程 url, NO 加载本地图片
 */
- (void) setStBannerLoadNetworkImage:(BOOL)stBannerLoadNetworkImage {
    _stBannerLoadNetworkImage = stBannerLoadNetworkImage;
}

/*!
 *  设置 stBanner 是否 开启 弹簧效果 默认是 YES
 *
 *  @param stBannerBounces  YES 开启, NO 关闭
 */
- (void) setStBannerBounces:(BOOL)stBannerBounces {
    _stBannerBounces = stBannerBounces;
    self.stBannerView.bounces = _stBannerBounces;
}

/*!
 *  设置 stBanner 中 PagesColor 是否 隐藏 默认 是 NO
 *
 *  @param stBannerPageControlHidden YES 隐藏, NO 显示
 */
- (void) setStBannerPageControlHidden:(BOOL)stBannerPageControlHidden {
    _stBannerPageControlHidden = stBannerPageControlHidden;
    self.stBannerPageControlView.hidden = _stBannerPageControlHidden;
}

/*!
 *  设置 stBanner 中 stPageBackgroundVeiw 是否 隐藏 默认 是 NO
 *
 *  @param stPageBackgroundVeiwHidden YES 隐藏, NO 显示
 */
- (void) setStPageBackgroundVeiwHidden:(BOOL)stPageBackgroundVeiwHidden {
    _stPageBackgroundVeiwHidden = stPageBackgroundVeiwHidden;
    self.stPageBackgroundVeiw.hidden = _stPageBackgroundVeiwHidden;
}

/*!
 *  设置 stBanner 中 PagesColor 总页数的颜色
 *
 *  @param numberOfPagesColor    颜色
 */
- (void)setNumberOfPagesColor:(UIColor *)numberOfPagesColor {
    _numberOfPagesColor = numberOfPagesColor;
    self.stBannerPageControlView.pageIndicatorTintColor = numberOfPagesColor;
}


/*!
 *  设置 stBanner 中 PagesColor 当前页数的颜色
 *
 *  @param currentPageColor      颜色
 */
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.stBannerPageControlView.currentPageIndicatorTintColor = currentPageColor;
}

/*!
 *  stBanner 注册一个cell
 *
 *  @param cellClass        注册 一个cell的类名
 *  @param identifier       cell ID (唯一标识)
 */
- (void) stBannerRegisterClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [self.stBannerView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}


/*!
 *  StBannerView 数据刷新
 */
- (void) stBannerReloadData {
    
    // 刷新数据
    [self.stBannerView reloadData];
    
    // 设置 图片的 位置 和 分页
    [self settingScrollAndPageControl];
}


#pragma mark - UICollectionView DataSource Methods && SwpBannerView DataSource Methods
/*!
 *  collectionView 数据源方法 (设置 collectionView 分组的 个数)
 *
 *  @param  collectionView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(stBannerViewNmberOfSections:)]) {
        return [self.dataSource stBannerViewNmberOfSections:self];
    } else {
        return 1;
    }
}

/*!
 * collectionView 数据源方法 (设置 collectionView 每个分组显示数据的个数)
 *
 *  @param  collectionView
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.section = section;
    NSLog(@"%ld",(long)[self.dataSource stBannerView:self numberOfItemsInSection:section]);
    return [self.dataSource stBannerView:self numberOfItemsInSection:section];
}

/*!
 *  collectionView 数据源方法 (设置 collectionView 每个cell显示的样式 和 数据)
 *  @param  collectionView
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 */
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isStBannerCustomCell) {
        // 使用 默认 cell
        STBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:stBannerCellID forIndexPath:indexPath];
        cell.loadNetworkImage   = self.stBannerLoadNetworkImage;
        cell.imageName          = [self.dataSource stBannerView:self cellTitleForItemAtIndexPath:indexPath];
        return cell;
    } else {
        return [self.dataSource stBannerView:self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }

}

#pragma mark - UICollectionView Delegate Methods && SwpBannerView Delegate Methods
/*!
 *  collectionView 代理方法 (设置 collectionView 每个cell的宽高)
 *
 *  @param  collectionView
 *  @param  collectionViewLayout
 *  @param  indexPath
 *
 *  @return CGSize
 */
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(stBannerView:collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.delegate stBannerView:self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

/*!
 *  collectionView 代理方法  (点击 collectionView 每个cell调用代理方法)
 *
 *  @param collectionView
 *  @param indexPath
 */
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(stBannerView:didSelectItemAtIndexPath:)]) {
        [self.delegate stBannerView:self didSelectItemAtIndexPath:indexPath];
    }
}


#pragma mark - Common Methods
/*!
 *  设置 图片 滚动属性 和 分页 属性
 */
- (void) settingScrollAndPageControl {
    
    
    // 移除自动滚动 防止 内存 泄露
    [self stopScroll];
    
    // 设置 pageControlView 总页数
    self.stBannerPageControlView.numberOfPages = [self.dataSource stBannerView:self numberOfItemsInSection:self.section];
    NSLog(@"设置 pageControlView 总页数-------%ld", (long)self.stBannerPageControlView.numberOfPages);
    
    
    NSString *str = [NSString stringWithFormat:@"%ld", (long)[self.dataSource stBannerView:self numberOfItemsInSection:self.section]];
    if (str.integerValue > 0) {
        self.stBannerPageBtn.frame          = CGRectMake(0, 0, SIDTH / str.integerValue, 1);
    }
    
    
    // 设置 pageControlView 当前也数
    self.stBannerPageControlView.currentPage   = 0;
    
    // 设置 图片 位置 为 第一张图片位置
    [self settingImageCollectionViewScrollScrollLocation:YES];
    
    // 启动 自动滚动
    [self beginScroll];
}

/*!
 *  scrollView 停止滚动
 */
- (void) stopScroll {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextImage) object:nil];
}

/*!
 *   scrollView 开始滚动
 */
- (void) beginScroll {
    
    self.stBannerTime = self.stBannerTime == 0 ? 5.0 : self.stBannerTime;
    [self performSelector:@selector(nextImage) withObject:nil afterDelay:self.stBannerTime];
    
}

/*!
 *  自动滚动
 */
- (void) nextImage {
    
    [self stopScroll];
    
    [self settingImageCollectionViewScrollScrollLocation:NO];
    
    [self beginScroll];
}


/*!
 *  设置 图片的 cell 的滚动 位置
 *
 *  @param initLocation 需要图片初始化 到第一张图片 YES 是初始化到第一张图片 NO 是不需要
 */
- (void) settingImageCollectionViewScrollScrollLocation:(BOOL)initLocation  {
    
    
    // 是否 实现了 数据源方法
    if (([self.dataSource respondsToSelector:@selector(stBannerView:numberOfItemsInSection:)] && [self.dataSource respondsToSelector:@selector(stBannerView:cellTitleForItemAtIndexPath:)]) ||  ([self.dataSource respondsToSelector:@selector(stBannerView:numberOfItemsInSection:)] && [self.dataSource respondsToSelector:@selector(stBannerView:collectionView:cellForItemAtIndexPath:)])) {
        
        NSIndexPath *currentIndexPath = [[self.stBannerView indexPathsForVisibleItems] lastObject];
        // initLocation 值为 YES 给 nextItem 赋 初始值 = 0 回到第一张图片
        NSInteger   nextItem          = initLocation ? 0 : currentIndexPath.item + 1;
        NSInteger   nextSection       = currentIndexPath.section;
        // initLocation 值为 NO 需要 判断 nextItem == 等于数据源 数组的长度，等于回到第一张图片
        if (!initLocation) {
            nextItem = nextItem == [self.dataSource stBannerView:self numberOfItemsInSection:self.section] ? 0 : nextItem;
        }
        
        
        // 数据源返回的 数组 是否 为 0
        if ([self.dataSource stBannerView:self numberOfItemsInSection:self.section] != 0) {
            NSIndexPath *nextIndexPath    = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
            [self.stBannerView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }
        
    }
    
}

#pragma mark - UIScrollView Delegate Methods
/*!
 *  scrollView 代理方法 (开始拖拽的时候调用)
 *
 *  @param scrollView
 */
- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    // 开始滚动
    [self beginScroll];
    
}

/*!
 *  scrollView 完全停止拖拽的时候调用
 *
 *  @param scrollView
 *  @param decelerate
 */
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 停止滚动
    [self stopScroll];
}

/*!
 *  scrollView 代理方法 (正在滚动时调用 ,计算分页)
 *
 *  @param scrollView
 */
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    // 精确分页
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width;
    //scrollView.contentOffset.x / scrollView.frame.size.width;
    self.stBannerPageControlView.currentPage = page;
    NSLog(@"page是几%d", page);
    
    NSString *str = [NSString stringWithFormat:@"%ld", (long)[self.dataSource stBannerView:self numberOfItemsInSection:self.section]];

    self.stBannerPageBtn.frame = CGRectMake(SIDTH / str.integerValue * page, 0, SIDTH / str.integerValue, 1);

}


#pragma mark -  Init UI Methods
- (UICollectionView *) stBannerView {
    if (!_stBannerView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection      = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing   = 0;
        
        _stBannerView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        [_stBannerView registerClass:[STBannerViewCell class] forCellWithReuseIdentifier:stBannerCellID];
        _stBannerView.backgroundColor                = [UIColor clearColor];
        _stBannerView.delegate                       = self;
        _stBannerView.dataSource                     = self;
        _stBannerView.pagingEnabled                  = YES;
        _stBannerView.showsHorizontalScrollIndicator = NO;
        _stBannerView.showsVerticalScrollIndicator   = NO;
    }
    return _stBannerView;
}

- (UIPageControl *) stBannerPageControlView {
    if (!_stBannerPageControlView) {
        _stBannerPageControlView                                = [[UIPageControl alloc] init];
        _stBannerPageControlView.pageIndicatorTintColor         = [UIColor blackColor];
        _stBannerPageControlView.currentPageIndicatorTintColor  = [UIColor redColor];
        _stBannerPageControlView.enabled                        = YES;
    }
    return _stBannerPageControlView;
}


- (UIView *) stPageBackgroundVeiw {
    if (!_stPageBackgroundVeiw) {
        _stPageBackgroundVeiw = [[UIView alloc] init];
        _stPageBackgroundVeiw.backgroundColor = [UIColor whiteColor];
    }
    return _stPageBackgroundVeiw;
}

- (UIButton *) stBannerPageBtn {
    if (!_stBannerPageBtn) {
        _stBannerPageBtn = [[UIButton alloc] init];
        _stBannerPageBtn.backgroundColor = [UIColor redColor];
    }
    return _stBannerPageBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
