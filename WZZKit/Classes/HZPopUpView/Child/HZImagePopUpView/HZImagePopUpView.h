//
//  HZImagePopUpView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/1.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HZTapImage)(void);
typedef void(^HZOnClickBtn)(void);

@interface HZImagePopUpView : HZPopUpView
///关闭按钮
@property (nonatomic, strong, readonly) UIButton *closeBtn;
///显示图片
@property (nonatomic, strong, readonly) UIButton *imageView;
///图片链接
@property (nonatomic, copy, readonly) NSString *imageUrl;
///占位图片
@property (nonatomic, strong, readonly) UIImage *placeholderImage;
///点击图片回调
@property (nonatomic, copy) HZTapImage tapImage;
///点击关闭按钮回调
@property (nonatomic, copy) HZOnClickBtn onClickCloseBtn;
- (void)hz_setImageUrl:(NSString * _Nonnull)imageUrl placeholderImage:(UIImage *)placeholderImage;

@end

NS_ASSUME_NONNULL_END
