//
//  JXTabbarView.h
//  JXTabbarView
//
//  Created by 肖扬 on 2019/2/28.
//  Copyright © 2019 肖扬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickButtonBlock)(NSInteger index);
typedef void(^clickSCNavBarBlock)(NSInteger index, int type);

@interface JXTabbarView : UIView
/// 当前位置
@property (nonatomic, assign) NSInteger currentIndex;
/// 点击按钮的block
@property (nonatomic, copy) clickButtonBlock buttonBlock;
/// 点击导航栏的block
@property (nonatomic, copy) clickSCNavBarBlock navBarBlock;

/**
 视图初始化

 @param frame 约束
 @param items 标题数组
 @param images 按钮数组
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items images:(NSArray *)images;

@end

NS_ASSUME_NONNULL_END
