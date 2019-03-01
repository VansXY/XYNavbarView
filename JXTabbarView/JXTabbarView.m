//
//  JXTabbarView.m
//  JXTabbarView
//
//  Created by 肖扬 on 2019/2/28.
//  Copyright © 2019 肖扬. All rights reserved.
//

#import "JXTabbarView.h"
#import "SCNavTabBar.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface JXTabbarView ()<SCNavTabBarDelegate>
/// 导航栏
@property (nonatomic, strong) SCNavTabBar *navTabBar;
/// 标题数组
@property (nonatomic, strong) NSArray *items;
/// button数组
@property (nonatomic, strong) NSArray *images;
@end

@implementation JXTabbarView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items images:(NSArray *)images {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _items = [NSArray arrayWithArray:items];
        _images = [NSArray arrayWithArray:images];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    [self addSubview:self.navTabBar];
    if (!_images.count) {
        return;
    }
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton.frame = CGRectMake(kWidth - 49, 0, 44, 44);
    [rightButton setImage:[UIImage imageNamed:_images[0]] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:rightButton];
    
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftButton.frame = CGRectMake(kWidth - 98, 0, 44, 44);
    [leftButton setImage:[UIImage imageNamed:_images[_images.count - 1]] forState:(UIControlStateNormal)];
    [leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:leftButton];
    leftButton.hidden = _images.count == 1;

}

- (void)clickRightButton:(UIButton *)sender {
    if (self.buttonBlock) {
        self.buttonBlock(1);
    }
}

- (void)clickLeftButton:(UIButton *)sender {
    if (self.buttonBlock) {
        self.buttonBlock(2);
    }
}


- (void)itemDidSelectedWithIndex:(NSInteger)index {
    if (self.navBarBlock) {
        self.navBarBlock(index, 1);
    }
}

- (void)itemsSlidingWithIndex:(NSInteger)index {
    if (self.navBarBlock) {
        self.navBarBlock(index, 2);
    }
}

- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height {
}



#pragma mark - setter / getter
- (void)setCurrentIndex:(NSInteger)currentIndex {
    self.navTabBar.currentItemIndex = currentIndex;
}

- (SCNavTabBar *)navTabBar {
    if (!_navTabBar) {
        _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(15, 0, 150, 44) showArrowButton:NO];
        _navTabBar.delegate = self;
        _navTabBar.itemTitles = _items;
        _navTabBar.backgroundColor = [UIColor clearColor];
        _navTabBar.btnUIControlStateNormalColor = [UIColor blackColor];
        _navTabBar.btnUIControlStateSelectedColor = [UIColor blackColor];
        _navTabBar.labboldSystemFontOfSize = 0;
        _navTabBar.arrowImage = nil;
        [_navTabBar updateData];
    }
    return _navTabBar;
}


@end
