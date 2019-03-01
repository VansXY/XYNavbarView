//
//  SCNavTabBar.h
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCNavTabBarDelegate <NSObject>

@optional
- (void)itemDidSelectedWithIndex:(NSInteger)index;

- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height;

- (void)itemsSlidingWithIndex:(NSInteger)index;

@end

@interface SCNavTabBar : UIView

@property (nonatomic, weak)     id          <SCNavTabBarDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray     *itemTitles;                // all items' title


@property (nonatomic, strong)   UIImage     *arrowImage;                // set arrow button's image



@property (nonatomic, strong)   UIColor     *btnUIControlStateNormalColor;                 // set the underscore color
@property (nonatomic, strong)   UIColor     *btnUIControlStateSelectedColor;                 // set the underscore color


@property (nonatomic, assign)   NSUInteger   labboldSystemFontOfSize;                 // set the underscore color


@property (nonatomic, strong)   UIButton     *currentChangeBtn;            

/**
 *  Initialize Methods
 *
 *  @param frame - SCNavTabBar frame
 *  @param show  - is show Arrow Button
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show;

/**
 *  Update Item Data
 */
- (void)updateData;

/**
 *  Refresh All Subview
 */
- (void)refresh;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
