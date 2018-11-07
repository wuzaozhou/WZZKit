//
//  HZBottomCell.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/4.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZBottomCell.h"
#import <Masonry/Masonry.h>
#import "HZPopUpView.h"

@implementation HZBottomCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self hz_addControl];
    }
    return self;
}

- (void)hz_addControl {
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor darkGrayColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = HZPopViewFont(14);
    [self.contentView addSubview:_textLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
//        make.left.equalTo(self.contentView).offset(10);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(50);
        make.height.equalTo(self.imageView.mas_width);
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
//        make.height.mas_equalTo(20);
    }];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
}


@end
