//
//  ViewController.m
//  SunTingBanner
//
//  Created by yinduo-zdy on 16/5/25.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ViewController.h"

#import "STBannerView.h"

@interface ViewController ()<STBannerViewDelegate, StBannerViewDataSource>

@property (nonatomic, strong) STBannerView *stBannerView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stBannerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    [self.view addSubview:self.stBannerView];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.array = @[ @"http://img.mlmsalon.com/ab2/1461554385587.png", @"http://img.mlmsalon.com/ab3/1461554422915.png", @"http://img.mlmsalon.com/banner3.png", @"http://img.mlmsalon.com/banner4.png", @"http://img.mlmsalon.com/ab6/1461554453731.png"];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  刷新轮播数据
 */
- (void)refreshData {
    [self.stBannerView stBannerReloadData];
}

#pragma mark - SwpBannerView DataSource Methods

/**
 *  StBannerView 数据源方法 (设置 swpBannerView 分组的 个数)
 *
 *  @param  swpBannerView
 *
 *  @return NSInteger
 */
- (NSInteger)stBannerViewNmberOfSections:(STBannerView *)swpBannerView {
    return 1;
}


/**
 *  STBannerView 数据源方法 (设置 swpBannerView 每个分组显示数据的个数)
 *
 *  @param  stBannerView
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger)stBannerView:(STBannerView *)stBannerView numberOfItemsInSection:(NSInteger)section {
    //    NSLog(@"看看有几个小点点 --- %lu", (unsigned long)self.array.count);
    return self.array.count;
}

/**
 *  STBannerView 数据源方法 (设置 swpBannerView 显示默认的cell 显示图片的名称)
 *
 *  (注意: stCustomCell 值 为 NO 时 才会调用， stCustomCell 默认为 NO)
 *
 *  @param  stBannerView
 *  @param  indexPath
 *
 *  @return NSString
 */
- (NSString *)stBannerView:(STBannerView *)swpBannerView cellTitleForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.array[indexPath.row]);
    return self.array[indexPath.row];
}


#pragma mark - SwpBannerView Deleage Methods

/**
 *  STBannerView 代理方法 (点击 swpBannerView 每个cell调用代理方法)
 *
 *  @param stBannerView
 *  @param indexPath
 */
- (void)stBannerView:(STBannerView *)stBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (STBannerView *) stBannerView {
    if (!_stBannerView) {
        _stBannerView                       = [[STBannerView alloc] init];
        _stBannerView.stBannerBounces       = NO;
        _stBannerView.numberOfPagesColor    = [UIColor whiteColor];
        _stBannerView.delegate              = self;
        _stBannerView.dataSource            = self;
        _stBannerView.stBannerPageControlHidden = YES;
    }
    return _stBannerView;
}

@end
