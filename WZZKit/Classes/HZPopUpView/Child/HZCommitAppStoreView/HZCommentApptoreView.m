//
//  HZCommentApptoreView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/3.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZCommentApptoreView.h"
#import <Masonry/Masonry.h>

NSString *const APPSTORECOMMENTURL = @"itms-apps://itunes.apple.com/cn/app/id1265707707?mt=8&action=write-review";

@interface HZCommentApptoreView ()
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation HZCommentApptoreView

///布局containerview的位置,就是那个看得到的视图
- (void)layoutContainerView {
    CGFloat width = 290;
    CGFloat height = 365;
    self.containerView.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-width)/2.0, (CGRectGetHeight([UIScreen mainScreen].bounds)-height)/2.0, width, height);
}

///设置containerview的属性,比如切边啥的
- (void)setupContainerViewAttributes {
    
}
///给containerview添加子视图
- (void)setupContainerSubViews {
    _contentView = [[UIView alloc] init];
    _contentView.layer.cornerRadius = 10;
    _contentView.layer.masksToBounds = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:_contentView];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(onClickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:_closeBtn];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"bg_tanchuang_haoping"];
    [_contentView addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = HZPopViewFont(14);
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_contentView addSubview:_titleLabel];
    
    _complaintsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_complaintsBtn addTarget:self action:@selector(onClickComplaintsBtn) forControlEvents:UIControlEventTouchUpInside];
    _complaintsBtn.titleLabel.font = HZPopViewFont(14);
    [_complaintsBtn setTitle:@"我要吐槽" forState:UIControlStateNormal];
    [_complaintsBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_contentView addSubview:_complaintsBtn];
    
    _encourageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_encourageBtn addTarget:self action:@selector(onClickComplaintsBtn) forControlEvents:UIControlEventTouchUpInside];
    _encourageBtn.titleLabel.font = HZPopViewFont(14);
    [_encourageBtn setTitle:@"鼓励一下" forState:UIControlStateNormal];
    [_encourageBtn setTitleColor:[UIColor colorWithRed:248/255.0 green:72/255.0 blue:94/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_contentView addSubview:_encourageBtn];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [_contentView addSubview:_line1];
    
    _line2 = [[UIView alloc] init];
    _line2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [_contentView addSubview:_line2];
}
///设置子视图的frame
- (void)layoutContainerViewSubViews {
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.containerView);
        make.width.height.mas_equalTo(30);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.containerView);
        make.top.equalTo(self.containerView).offset(50);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-130);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.imageView.mas_bottom);
        make.bottom.equalTo(self.contentView).offset(-44);
    }];
    [_complaintsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.encourageBtn.mas_left);
        make.width.equalTo(self.encourageBtn);
        make.height.mas_equalTo(44);
    }];
    [_encourageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.complaintsBtn.mas_right);
        make.width.equalTo(self.complaintsBtn);
        make.height.equalTo(self.complaintsBtn);
        make.bottom.equalTo(self.complaintsBtn);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.line1).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(1);
    }];
}

///点击关闭按钮
- (void)onClickCloseBtn {
    [self dismissAnimated:YES];
}

///点击画鼓励或者吐槽按钮
- (void)onClickComplaintsBtn {
    NSString *url=[APPSTORECOMMENTURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *appStoreUrl=[NSURL URLWithString:url];
    if ([[UIDevice currentDevice].systemVersion integerValue]>=10.0) {
        if ([[UIApplication sharedApplication] canOpenURL:appStoreUrl]) {
            [[UIApplication sharedApplication] openURL:appStoreUrl options:@{} completionHandler:nil];
        }
    }else if ([[UIApplication sharedApplication] canOpenURL:appStoreUrl]) {
        [[UIApplication sharedApplication] openURL:appStoreUrl];
    }
    [self dismissAnimated:YES];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _titleLabel.text = message;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutContainerView];
}

@end
