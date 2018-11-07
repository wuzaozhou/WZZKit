//
//  HZPopUpView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/1.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define HZPopViewFont(num)   [[UIDevice currentDevice].systemVersion integerValue]<9?[UIFont systemFontOfSize:num]: [UIFont fontWithName:@"PingFang SC" size:num]
//蒙版透明度
typedef enum : NSUInteger {
    KKAlertViewBackgroundStyleTransparent,//全透明
    KKAlertViewBackgroundStyleTranslucent,//半透明
} KKAlertViewBackgroundStyle;


//动画效果
typedef enum : NSUInteger {
    KKAlertViewTransitionStyleNone,
    KKAlertViewTransitionStyleSlideFromBottom,
    KKAlertViewTransitionStyleFade,
    KKAlertViewTransitionStyleBounce,
    KKAlertViewTransitionStyleDropDown,
    KKAlertViewTransitionStyleSlideFromTop,
} KKAlertViewTransitionStyle;


@interface HZPopUpView : UIView
@property (nonatomic, assign) KKAlertViewBackgroundStyle backgroundStyle;//背景效果
@property (nonatomic, strong) UIView *containerView;//容器视图
@property (nonatomic, assign, getter = isVisible) BOOL visible;//是否正在显示
@property (nonatomic, assign) BOOL isAutoHidden;//是否点击背景隐藏
@property (nonatomic, assign) KKAlertViewTransitionStyle transitionStyle;//动画效果
@property (nonatomic, strong) UIView *backgroundView;//背景
@property (nonatomic, assign) NSInteger level;//层次等级，0表示最高层，显示在最上面


/**
 初始化方法，默认背景能点击

 @param transitionStyle 动画
 @param backgrounpStyle 背景
 @return HZPopUpView
 */
- (instancetype)initWithAnimationStyle:(KKAlertViewTransitionStyle)transitionStyle backgrounpStyle:(KKAlertViewBackgroundStyle)backgrounpStyle;


/**
 初始化

 @param transitionStyle 动画
 @param backgrounpStyle 背景
 @param isAutoHidden 背景是否能点击
 @return HZPopUpView
 */
- (instancetype)initWithAnimationStyle:(KKAlertViewTransitionStyle)transitionStyle backgrounpStyle:(KKAlertViewBackgroundStyle)backgrounpStyle isAutoHidden:(BOOL)isAutoHidden;

//继承者需要实现的
/** 布局containerview的位置,就是那个看得到的视图 */
- (void)layoutContainerView;
/** 设置containerview的属性,比如切边啥的 */
- (void)setupContainerViewAttributes;
/** 给containerview添加子视图 */
- (void)setupContainerSubViews;
/** 设置子视图的frame */
- (void)layoutContainerViewSubViews;

//展示和消失
- (void)dismissAnimated:(BOOL)animated;
- (void)show;
@end

NS_ASSUME_NONNULL_END
