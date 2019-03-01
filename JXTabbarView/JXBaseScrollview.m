//
//  JXBaseScrollview.m
//  JXTabbarView
//
//  Created by 肖扬 on 2019/2/28.
//  Copyright © 2019 肖扬. All rights reserved.
//

#import "JXBaseScrollview.h"
#import "JXTabbarView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface JXBaseScrollview ()<UIScrollViewDelegate>
/// 导航栏
@property (nonatomic, strong) JXTabbarView *navTabBar;
/// 滚动视图
@property (nonatomic, strong) UIScrollView *mainView;
/// 标题数组
@property (nonatomic, strong) NSArray *items;

@end

@implementation JXBaseScrollview

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    if (self = [super initWithFrame:frame]) {
        _items = items;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.navTabBar];
    __weak typeof(self)weakSelf = self;
    self.navTabBar.buttonBlock = ^(NSInteger index) {
        NSLog(@"%@", [NSString stringWithFormat:@"%ld", index]);
    };

    self.navTabBar.navBarBlock = ^(NSInteger index, int type) {
        if (type == 1) {
            [weakSelf.mainView setContentOffset:CGPointMake(index*kWidth, 0) animated:NO];
            weakSelf.navTabBar.currentIndex = index;
            if (weakSelf.indexBlock) {
                weakSelf.indexBlock(index);
            }
        }
    };
    
    [self addSubview:self.mainView];
    for (int i = 0; i < self.items.count; i++) {
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight - 88)];
        [self.mainView addSubview:tempView];
        tempView.backgroundColor = [UIColor colorWithRed:55 * i / 255.0 green:55 * i / 255.0  blue:55 * i / 255.0  alpha:1];
    }
}

- (void)setViews:(NSArray *)views {
    
}

#pragma mark - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentIndex = scrollView.contentOffset.x / kWidth;
    _navTabBar.currentIndex = currentIndex;
    if (self.indexBlock) {
        self.indexBlock(currentIndex);
    }
}

#pragma mark - setter / getter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    self.navTabBar.currentIndex = currentIndex;
    self.mainView.contentOffset = CGPointMake(kWidth*currentIndex, 0);
}

- (JXTabbarView *)navTabBar {
    if (!_navTabBar) {
        _navTabBar = [[JXTabbarView alloc] initWithFrame:CGRectMake(0, 44, kWidth, 44) items:@[@"关注", @"直播", @"广场"] images:@[@"jx_iphone_share", @"jx_iphone_songlist"]];
    }
    return _navTabBar;
}

- (UIScrollView *)mainView {
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 + 44, kWidth, kHeight - 88)];
        _mainView.delegate = self;
        _mainView.pagingEnabled = YES;
        _mainView.bounces = NO;
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.contentSize = CGSizeMake(kWidth * _items.count, 0);
    }
    return _mainView;
}


@end
