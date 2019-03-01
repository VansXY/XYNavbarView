# XYNavbarView
一个类似于陌陌首页的基础视图

![image](https://github.com/VansXY/XYNavbarView/blob/master/%E5%9F%BA%E7%A1%80%E8%A7%86%E5%9B%BE%E6%A0%B7%E5%BC%8F.jpg)

- 可以设置items 和 currentIndex 来创建视图

```
    JXBaseScrollview *mainView = [[JXBaseScrollview alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) items:@[@"关注", @"直播", @"广场"]];
    mainView.currentIndex = 1;
    [self.view addSubview:mainView];
```



- 右上角的标签可以通过数组 images 来设置

```
    _navTabBar = [[JXTabbarView alloc] initWithFrame:CGRectMake(0, 44, kWidth, 44) items:_items images:@[@"jx_iphone_share", @"jx_iphone_songlist"]];
    self.navTabBar.currentIndex = currentIndex;
    [self addSubview:self.navTabBar];
```
