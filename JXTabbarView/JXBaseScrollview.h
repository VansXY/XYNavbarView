//
//  JXBaseScrollview.h
//  JXTabbarView
//
//  Created by 肖扬 on 2019/2/28.
//  Copyright © 2019 肖扬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnIndexBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface JXBaseScrollview : UIView
/// 当前的位置
@property (nonatomic, assign) NSInteger currentIndex;
/// 添加的视图
@property (nonatomic, strong) NSArray *views;
/// 返回scrollview的index
@property (nonatomic, copy) returnIndexBlock indexBlock;


- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END
