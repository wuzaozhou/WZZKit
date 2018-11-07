//
//  HZUpgradeVersionView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/2.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZUpgradeVersionView.h"
#import <Masonry/Masonry.h>


static CGFloat viewWidth = 312;
static CGFloat viewHeight = 400;
NSString *const APPSTOREUPDATEURL = @"itms-apps://itunes.apple.com/app/id1265707707";

@implementation HZUpgradeVersionView


//布局containerview的位置,就是那个看得到的视图
- (void)layoutContainerView {
    CGFloat width = (viewWidth)*[UIScreen mainScreen].bounds.size.width/375;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width-width)/2.0;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height-viewHeight)/2.0;
    self.containerView.frame = CGRectMake(x, y, width, viewHeight);
    
}

//设置containerview的属性,比如切边啥的
- (void)setupContainerViewAttributes {
    
}

//给containerview添加子视图
- (void)setupContainerSubViews {
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"bg_gengxintishi"];
    [self.containerView addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = HZPopViewFont(18);
    _titleLabel.textColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    _titleLabel.text = @"发现新版本1.4.0";
    [self.containerView addSubview:_titleLabel];
    
    _tipsLabel = [[UILabel alloc] init];
    _tipsLabel.font = HZPopViewFont(14);
    _tipsLabel.numberOfLines = 0;
    _tipsLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.containerView addSubview:_tipsLabel];
    
    
    _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_updateButton setBackgroundImage:[UIImage imageNamed:@"bun_lijishengji"] forState:0];
    [_updateButton setTitle:@"立即升级" forState:0];
    [_updateButton setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:0];
    [_updateButton.titleLabel setFont:HZPopViewFont(16)];
    [_updateButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _updateButton.tag = 1;
    [self.containerView addSubview:_updateButton];
    
    _dnrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dnrButton setTitle:@"暂不更新" forState:0];
    [_dnrButton setTitleColor:[UIColor colorWithRed:248/255.0 green:72/255.0 blue:94/255.0 alpha:1.0] forState:0];
    [_dnrButton.titleLabel setFont:HZPopViewFont(16)];
    [_dnrButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _dnrButton.tag = 0;
    [self.containerView addSubview:_dnrButton];

}

//设置子视图的frame
- (void)layoutContainerViewSubViews {
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.containerView);
        make.center.equalTo(self.containerView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containerView).offset(-15);
        make.top.equalTo(self.containerView).offset(65);
        make.height.mas_equalTo(20);
    }];
    [_dnrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.containerView).offset(-20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.containerView);
    }];
    [_updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dnrButton.mas_top).offset(-20);
        make.width.equalTo(self.dnrButton);
        make.height.equalTo(self.dnrButton);
        make.centerX.equalTo(self.dnrButton);
    }];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.containerView).offset(15);
        make.right.equalTo(self.containerView).offset(-15);
        make.bottom.equalTo(self.updateButton.mas_top).offset(-15);
    }];
}

- (void)setUpdateMessage:(NSString *)updateMessage {
    _updateMessage = updateMessage;
    NSMutableParagraphStyle *paraStyle=[[NSMutableParagraphStyle alloc]init];
    paraStyle.lineSpacing = 5;
    paraStyle.paragraphSpacing = 15;
    paraStyle.headIndent = 14*1.5;
    paraStyle.firstLineHeadIndent = 0;
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:updateMessage attributes:@{NSParagraphStyleAttributeName: paraStyle}];
    _tipsLabel.attributedText = str;
}

//点击升级按钮
- (void)btnClick:(UIButton *)btn {
    [self dismissAnimated:YES];
    if (btn.tag == 1) {//更新按钮
        //跳转到更新页面
        NSString *url=[APPSTOREUPDATEURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *appStoreUrl=[NSURL URLWithString:url];
        if ([[UIDevice currentDevice].systemVersion integerValue]>=10.0) {
            if ([[UIApplication sharedApplication] canOpenURL:appStoreUrl]) {
                [[UIApplication sharedApplication] openURL:appStoreUrl options:@{} completionHandler:nil];
            }
        }else if ([[UIApplication sharedApplication] canOpenURL:appStoreUrl]) {
            [[UIApplication sharedApplication] openURL:appStoreUrl];
            
        }
    }
}

@end




