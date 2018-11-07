//
//  HZImagePopUpView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/1.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZImagePopUpView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIButton+WebCache.h>

@implementation HZImagePopUpView
//布局containerview的位置,就是那个看得到的视图
- (void)layoutContainerView {
    self.containerView.frame = CGRectMake(30, ([UIScreen mainScreen].bounds.size.height-350)/2.0, [UIScreen mainScreen].bounds.size.width-60, 350);
    
}
//设置containerview的属性,比如切边啥的
- (void)setupContainerViewAttributes {
    
}
//给containerview添加子视图
- (void)setupContainerSubViews {
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:_closeBtn];
    
    _imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView addTarget:self action:@selector(imgTap) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:_imageView];
    
}
//设置子视图的frame
- (void)layoutContainerViewSubViews {
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView);
        make.top.equalTo(self.containerView).offset(50);
    }];
    
    [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.width.height.mas_equalTo(30);
        make.right.mas_equalTo(self.imageView.mas_right);
        make.bottom.mas_equalTo(self.imageView.mas_top).offset(-10);
    }];
}

///点击关闭按钮
- (void)onClickBtn:(UIButton *)btn {
    _onClickCloseBtn ? _onClickCloseBtn() : nil;
    [self dismissAnimated:YES];
}

///点击图片
- (void)imgTap {
    _tapImage ? _tapImage() : nil;
    [self dismissAnimated:YES];
}

//设置图片
- (void)hz_setImageUrl:(NSString * _Nonnull)imageUrl placeholderImage:(UIImage * __nonnull)placeholderImage {
    _imageUrl = imageUrl;
    _placeholderImage = placeholderImage;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] forState:UIControlStateNormal placeholderImage:_placeholderImage];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] forState:UIControlStateHighlighted placeholderImage:_placeholderImage];
    
}
@end
