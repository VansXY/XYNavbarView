//
//  ViewController.m
//  JXTabbarView
//
//  Created by 肖扬 on 2019/2/28.
//  Copyright © 2019 肖扬. All rights reserved.
//

#import "ViewController.h"
#import "JXBaseScrollview.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    
    JXBaseScrollview *mainView = [[JXBaseScrollview alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) items:@[@"关注", @"直播", @"广场"]];
    mainView.indexBlock = ^(NSInteger index) {
        NSLog(@"%@", [NSString stringWithFormat:@"滑到了%ld页", index]);
    };
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.currentIndex = 1;
    [self.view addSubview:mainView];
    
    
}


@end
