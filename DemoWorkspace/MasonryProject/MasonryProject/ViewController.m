//
//  ViewController.m
//  MasonryProject
//
//  Created by mac on 2020/6/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self masonry1];
    
    //    [self masonry2];
    
    //    [self masonryLabel];
    
    //    [self masonryBtnAndLabel];
    
    [self masonryScrollView];
    
    // Do any additional setup after loading the view.
}

- (void)masonry1 {
    /**
     下面的例子是通过给equalTo()方法传入一个数组，设置数组中子视图及当前make对应的视图之间等高。
     
     需要注意的是，下面block中设置边距的时候，应该用insets来设置，而不是用offset。
     因为用offset设置right和bottom的边距时，这两个值应该是负数，所以如果通过offset来统一设置值会有问题。
     */
    
    CGFloat padding = 10;
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    //       /**********  等高   ***********/
    //       [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //           make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    //           make.bottom.equalTo(blueView.mas_top).offset(-padding);
    //       }];
    //       [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
    //           make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, 0, padding));
    //           make.bottom.equalTo(yellowView.mas_top).offset(-padding);
    //       }];
    //
    //       /**
    //        下面设置make.height的数组是关键，通过这个数组可以设置这三个视图高度相等。其他例如宽度之类的，也是类似的方式。
    //        */
    //       [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
    //           make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
    //           make.height.equalTo(@[blueView, redView]);
    //       }];
    
    /**********  等宽   ***********/
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, padding, 0));
        make.right.equalTo(blueView.mas_left).offset(padding);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, 0));
        make.right.equalTo(yellowView.mas_left).offset(-padding);
    }];
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(padding, 0, padding, padding));
        make.width.equalTo(@[redView, blueView]);
    }];
    
}

- (void)masonry2 {
    CGFloat padding = 10;
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).mas_offset(padding);
        make.right.equalTo(blueView.mas_left).mas_offset(-padding);
        //make.width.equalTo(blueView);
        make.height.mas_equalTo(150);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).mas_offset(-padding);
        make.width.equalTo(redView);
        make.height.mas_equalTo(150);
    }];
}

- (void)masonryLabel {
    UILabel *firstLabel = [UILabel new];
    [self.view addSubview:firstLabel];//必须先添加
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    firstLabel.backgroundColor = [UIColor greenColor];
    
    
    firstLabel.text = @"阿斯蒂芬阿斯蒂芬sad发斯蒂芬阿萨德发阿斯蒂芬玩儿请问日期二去玩儿去玩儿人情味儿";
    
    //设置行数为0，不设置高度
    firstLabel.numberOfLines = 0;
    [firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.width.mas_equalTo(200);
    }];
}

- (void)masonryBtnAndLabel {
    UILabel *firstLabel = [UILabel new];
    UIButton *changgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:firstLabel];//必须先添加
    [self.view addSubview:changgeButton];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    
    [changgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(firstLabel);
        make.top.equalTo(firstLabel.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [changgeButton addTarget:self action:@selector(clickAction_change:) forControlEvents:UIControlEventTouchUpInside];
    changgeButton.backgroundColor = [UIColor yellowColor];
    [changgeButton setTitle:@"更新约束" forState:UIControlStateNormal];
    [changgeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changgeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    firstLabel.backgroundColor = [UIColor greenColor];
}

- (void)clickAction_change:(UIButton *)sender {
    //更新约束
    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //其实之前写的两条约束还是在的就相当于以下代码
    /**
     [sender mas_remakeConstraints:^(MASConstraintMaker *make) {
     make.centerX.equalTo(firstLabel);
     make.top.equalTo(firstLabel.mas_bottom).offset(100);
     make.size.mas_equalTo(CGSizeMake(100, 100));;//只是更新了这个约束
     }];
     但是由于在这里拿不到firstLabel这个对象,所以不能用这个方法
     */
    
    //    [sender mas_remakeConstraints:^(MASConstraintMaker *make) {
    //           make.centerX.equalTo(self.view);
    //           make.top.equalTo(self.view).offset(200);
    //           make.size.mas_equalTo(CGSizeMake(100, 100));
    //       }];
}

- (void)masonryScrollView {
    UIButton *changgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView *contentView = [UIView new];//加个子视图作为内容视图
    UIView *firstView = [UIView new];
    UIView *secondView = [UIView new];
    UIView *ThirdView = [UIView new];
    UIView *forthView = [UIView new];
    UIView *fifthView = [UIView new];
    NSArray *array = [NSArray arrayWithObjects:ThirdView, forthView, fifthView, nil];//加入到数组中
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:contentView];
    [contentView addSubview:firstView];
    [contentView addSubview:secondView];
    [contentView addSubview:ThirdView];
    [contentView addSubview:forthView];
    [contentView addSubview:fifthView];
    [contentView addSubview:changgeButton];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
        /*如果设置内容撑开scrollview，就不需要设置高度，而是在最后添加
         [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(fifthView.mas_bottom).offset(100);
        }];
         */
    }];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(200);
        make.width.equalTo(firstView).multipliedBy(0.33);
        make.height.equalTo(firstView).multipliedBy(0.88);
    }];
    [changgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView).offset(740);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    /**
     *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
     *
     *  @param axisType        轴线方向
     *  @param fixedSpacing    间隔大小
     *  @param leadSpacing     头部间隔
     *  @param tailSpacing     尾部间隔
     */
//    //横向排列 间隔距离固定 array中的元素必须最少要三个
//    //1.间隔固定，长度不固定
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
//
//    //2.控件长度固定，间隔不固定
////    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:5 tailSpacing:5];
//
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(contentView).offset(300);
//        make.height.mas_equalTo(50);
//    }];
    
    //纵向排列
    //1.间隔固定，长度不固定
    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:50 leadSpacing:280 tailSpacing:200];
    //2.控件长度固定，间隔不固定  不是很实用的样子
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:100 leadSpacing:5 tailSpacing:5];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo(100);
    }];
    
    
    contentView.backgroundColor = [UIColor lightGrayColor];
    firstView.backgroundColor = [UIColor greenColor];
    secondView.backgroundColor = [UIColor orangeColor];
    ThirdView.backgroundColor = [UIColor redColor];
    forthView.backgroundColor = [UIColor cyanColor];
    fifthView.backgroundColor = [UIColor blueColor];
    [changgeButton addTarget:self action:@selector(clickAction_change:) forControlEvents:UIControlEventTouchUpInside];
    changgeButton.backgroundColor = [UIColor yellowColor];
    [changgeButton setTitle:@"更新约束" forState:UIControlStateNormal];
    [changgeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changgeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
