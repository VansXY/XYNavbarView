//
//  SCNavTabBar.m
//  SCNavTabBarController
//
//  Created by ShiCang on 14/11/17.
//  Copyright (c) 2014年 SCNavTabBarController. All rights reserved.
//

#import "SCNavTabBar.h"
#import "UIView+Sizes.h"

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)
#define DOT_COORDINATE                  0.0f
#define STATUS_BAR_HEIGHT               20.0f
#define BAR_ITEM_WIDTH_HEIGHT           30.0f
#define NAVIGATION_BAR_HEIGHT           44.0f
#define TAB_TAB_HEIGHT                  49.0f
#define DeviceScale6     (SCREEN_WIDTH / 375.f)

#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define ARROW_BUTTON_WIDTH              NAVIGATION_BAR_HEIGHT
#define NAV_TAB_BAR_HEIGHT              ARROW_BUTTON_WIDTH
#define ITEM_HEIGHT                     NAV_TAB_BAR_HEIGHT


@interface SCNavTabBar () 
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    UIImageView     *_arrowButton;          // arrow button
    
    UIView          *_line;                 // underscore show which item selected
    //SCPopView       *_popView;              // when item menu, will show this view
    
    NSMutableArray  *_items;                // SCNavTabBar pressed item
    NSArray         *_itemsWidth;           // an array of items' width
    BOOL            _showArrowButton;       // is showed arrow button
    BOOL            _popItemMenu;           // is needed pop item menu
}

@end

@implementation SCNavTabBar

- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _showArrowButton = show;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initConfig
{
    _items = [@[] mutableCopy];
    
    
    [self viewConfig];
    [self addTapGestureRecognizer];
    
    _labboldSystemFontOfSize = 15;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(JXHomeCategoryCellMainViewTitleChange:) name:JXHomeCategoryCellMainViewTitleChange object:nil];
    
}

//- (void)JXHomeCategoryCellMainViewTitleChange:(NSNotification *)notification
//{
//    //    NSString *cityCode = notification.userInfo[@"cityCode"];
//    if (_items.count < 3) {
//        return;
//    }
//    NSString *cityName = notification.userInfo[@"cityName"];
//    UIButton *button  = _items[2];
//    [button setTitle:cityName forState:UIControlStateNormal];
//}


- (void)viewConfig
{
    CGFloat functionButtonX = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    if (_showArrowButton)
    {
        _arrowButton = [[UIImageView alloc] initWithFrame:CGRectMake(functionButtonX, DOT_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH)];
        //        _arrowButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _arrowButton.image = _arrowImage;
        _arrowButton.userInteractionEnabled = YES;
        [self addSubview:_arrowButton];
        [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
        [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    }
    
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.self.frame.size.height)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    //    _navgationTabBar.backgroundColor = [UIColor redColor];
    //
    //    [self viewShowShadow:self shadowRadius:10.0f shadowOpacity:10.0f];
    
//    UIImageView *leftYinYingView = [[UIImageView alloc] init];
//    leftYinYingView.image = [UIImage jx_imageNamed:@"jjxHome2daohangmengban-zuo"];
//    [self addSubview:leftYinYingView];
//    leftYinYingView.backgroundColor = [UIColor clearColor];
//    leftYinYingView.frame = CGRectMake(0, 0, 17, 15);
//    leftYinYingView.centerY = _navgationTabBar.centerY;
//    leftYinYingView.tag = 5001;
    
//    UIImageView *roghtYinYingView = [[UIImageView alloc] init];
//    roghtYinYingView.image = [UIImage jx_imageNamed:@"jjxHome2daohangmengban"];
//    [self addSubview:roghtYinYingView];
//    roghtYinYingView.backgroundColor = [UIColor clearColor];
//    roghtYinYingView.frame = CGRectMake(self.width-17, 0, 17, 15);
//    roghtYinYingView.centerY = _navgationTabBar.centerY;
//    leftYinYingView.tag = 5002;
    
    
    
    
}

- (void)showLineWithButtonWidth:(CGFloat)width withIndex:(NSInteger) index {
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.self.frame.size.height-3-6, 11*DeviceScale6, 3)];
    if(_labboldSystemFontOfSize > 0) {
        _line.frame= CGRectMake(0, self.frame.size.height-3-10, 11*DeviceScale6, 3);
    }
    _line.centerX =    ((UIButton *)(_items[index])).centerX;
    _line.backgroundColor = UIColorWithRGBA(20.0f, 80.0f, 200.0f, 0.7f);
    _line.layer.cornerRadius = 1.5*DeviceScale6;
    _line.layer.masksToBounds = YES;
    
    
    if (_btnUIControlStateSelectedColor) {
        _line.backgroundColor = [UIColor purpleColor];
    } else {
        _line.backgroundColor = [UIColor orangeColor];
    }
    
    [_navgationTabBar addSubview:_line];
}

- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    
    if (_itemTitles.count == 2) {
        [[self viewWithTag:5001] removeFromSuperview];
        [[self viewWithTag:5002] removeFromSuperview];
    }
    
    
    CGFloat buttonX = DOT_COORDINATE;
    for (NSInteger index = 0; index < [_itemTitles count]; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, [widths[index] floatValue], self.frame.size.height);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        
        if (_itemTitles.count == 2) {
            if (index == 0) {
                button.titleEdgeInsets = UIEdgeInsetsMake(0, button.frame.size.width/2, 0, 0);
            } else {
                button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.frame.size.width/2, 0, 0);
            }
        }
        
        if ([_itemTitles[index] isEqualToString:@"巨星"]) {
            self.currentChangeBtn = button;
        }
        
        if (_btnUIControlStateNormalColor) {
            [button setTitleColor:_btnUIControlStateNormalColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor lightGrayColor]  forState:UIControlStateNormal];
        }
        
        if (_btnUIControlStateSelectedColor) {
            [button setTitleColor:_btnUIControlStateSelectedColor  forState:UIControlStateSelected];
        } else {
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        }

        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16*DeviceScale6];
        
        if (_labboldSystemFontOfSize != 0)
        {
            button.titleLabel.font = [UIFont systemFontOfSize:_labboldSystemFontOfSize*DeviceScale6];
            
        }
        
        [_navgationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
    }
    
    
    ((UIButton *)(_items[0])).selected = YES;
    if(_labboldSystemFontOfSize==0)
    {
        ((UIButton *)(_items[0])).titleLabel.font = [UIFont boldSystemFontOfSize:20*DeviceScale6];
    }
    [self showLineWithButtonWidth:[widths[0] floatValue] withIndex:0];
    return buttonX;
}



- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
}

- (void)itemPressed:(UIButton *)button
{
    for (UIButton *btn in _items)
    {
        btn.selected = NO;
        if(_labboldSystemFontOfSize==0)
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:16*DeviceScale6];
        }
    }
    button.selected = YES;
    if(_labboldSystemFontOfSize==0)
    {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18*DeviceScale6];
    }
    
    
    
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

- (void)functionButtonPressed
{
    _popItemMenu = !_popItemMenu;
    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles {
    NSMutableArray *widths = [@[] mutableCopy];
    for (NSString *title in titles) {
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:[UIFont systemFontSize]]}];
        NSNumber *width = [NSNumber numberWithFloat:size.width + 30.0f];
        
        if (titles.count <= 4 || titles.count == 5) {
            width = [NSNumber numberWithFloat:self.frame.size.width/titles.count ];
        }
        [widths addObject:width];
    }
    
    return widths;
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    //    view.layer.shadowRadius = shadowRadius;
    //    view.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)popMenuHeight
{
    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = ITEM_HEIGHT;
    CGFloat maxHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - NAV_TAB_BAR_HEIGHT;
    for (NSInteger index = 0; index < [_itemsWidth count]; index++)
    {
        buttonX += [_itemsWidth[index] floatValue];
        
        @try {
            if ((buttonX + [_itemsWidth[index + 1] floatValue]) >= SCREEN_WIDTH)
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    buttonY = (buttonY > maxHeight) ? maxHeight : buttonY;
    return buttonY;
}

- (void)popItemMenu:(BOOL)pop {
    if (pop) {
        [self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
        [UIView animateWithDuration:0.5f animations:^{
            _navgationTabBar.hidden = YES;
            _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2f animations:^{
            }];
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            _arrowButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            _navgationTabBar.hidden = !_navgationTabBar.hidden;
            [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
        }];
    }
}

#pragma mark -
#pragma mark - Public Methods
- (void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage ? arrowImage : _arrowImage;
    _arrowButton.image = _arrowImage;
}

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    if ([_delegate respondsToSelector:@selector(itemsSlidingWithIndex:)])
    {
        [_delegate itemsSlidingWithIndex:currentItemIndex];
    }
    
    
    
    
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    CGFloat flag = _showArrowButton ? (self.frame.size.width - self.frame.size.height) : self.frame.size.width;
    
    if (button.frame.origin.x + button.frame.size.width > flag) {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count] - 1) {
            offsetX = offsetX + 40.0f;
        }
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    } else {
        [_navgationTabBar setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        if (_itemTitles.count == 2) {
            if (currentItemIndex == 0) {
                _line.centerX = button.centerX +  button.frame.size.width/2/2;
            } else{
                _line.centerX = button.centerX -  button.frame.size.width/2/2;
            }
        } else {
            _line.centerX = button.centerX;
        }
    }];

    for (UIButton *btn in _items) {
        btn.selected = NO;
        if(_labboldSystemFontOfSize==0) {
            btn.titleLabel.font = [UIFont systemFontOfSize:16*DeviceScale6];
        }
    }
    
    ((UIButton *)(_items[currentItemIndex])).selected = YES;
    if(_labboldSystemFontOfSize==0) {
        ((UIButton *)(_items[currentItemIndex])).titleLabel.font = [UIFont boldSystemFontOfSize:18*DeviceScale6];
    }
}

- (void)updateData
{
    _arrowButton.backgroundColor = self.backgroundColor;
    
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
    }
}

- (void)refresh
{
    [self popItemMenu:_popItemMenu];
}

#pragma mark - SCFunctionView Delegate Methods
#pragma mark -
- (void)itemPressedWithIndex:(NSInteger)index
{
    [self functionButtonPressed];
    [_delegate itemDidSelectedWithIndex:index];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
