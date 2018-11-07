//
//  HZPopUpView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/1.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"

static CGFloat animationTime = 0.5;

@interface HZPopUpView ()<CAAnimationDelegate>

@end

@implementation HZPopUpView

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionStyle = KKAlertViewTransitionStyleNone;
        _backgroundStyle = KKAlertViewBackgroundStyleTranslucent;
        _isAutoHidden = NO;
    }
    return self;
}


- (instancetype)initWithAnimationStyle:(KKAlertViewTransitionStyle)transitionStyle backgrounpStyle:(KKAlertViewBackgroundStyle)backgrounpStyle {
    return [self initWithAnimationStyle:transitionStyle backgrounpStyle:backgrounpStyle isAutoHidden:YES];
}

- (instancetype)initWithAnimationStyle:(KKAlertViewTransitionStyle)transitionStyle backgrounpStyle:(KKAlertViewBackgroundStyle)backgrounpStyle isAutoHidden:(BOOL)isAutoHidden {
    if (self = [super init]) {
        _transitionStyle = transitionStyle;
        _backgroundStyle = backgrounpStyle;
        _isAutoHidden = isAutoHidden;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self hz_addControl];
    }
    return self;
}

- (void)hz_addControl {
    _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backgroundView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgrounpView)];
    _backgroundView.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_backgroundView addGestureRecognizer:tap];
    [self addSubview:_backgroundView];
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.clipsToBounds = YES;
    [self addSubview:self.containerView];
    [self layoutContainerView];
    [self setupContainerViewAttributes];
    [self setupContainerSubViews];
    [self layoutContainerViewSubViews];
}


//布局containerview的位置,就是那个看得到的视图
- (void)layoutContainerView {
    
}
//设置containerview的属性,比如切边啥的
- (void)setupContainerViewAttributes {
    
}
//给containerview添加子视图
- (void)setupContainerSubViews {
    
}
//设置子视图的frame
- (void)layoutContainerViewSubViews {
    
}

///点击背景
- (void)tapBackgrounpView {
    if (_isAutoHidden) {
        [self dismissAnimated:YES];
    }
}

- (void)show {
    
    if (_level == 0) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }else {
        NSInteger type = 0;
        for (id obj in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([obj isKindOfClass:[HZPopUpView class]]) {
                HZPopUpView *subView = (HZPopUpView *)obj;
                if (subView.level <= self.level) {
                    [[UIApplication sharedApplication].keyWindow insertSubview:self belowSubview:subView];
                    type = 1;
                    break;
                }
            }
        }
        if (type == 0) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
    }
    if (_backgroundStyle == KKAlertViewBackgroundStyleTransparent) {
        _backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
    }else {
        [UIView animateWithDuration:1.0 animations:^{
            self.backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        } completion:nil];
    }
    _visible = YES;
    [self transitionInCompletion:nil];
}

- (void)dismissAnimated:(BOOL)animated {
    [UIView animateWithDuration:animationTime animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
    } completion:nil];
    [self resetTransition];
    if (self.isVisible && animated) {
        [self transitionOutCompletion:^{
            [self removeFromSuperview];
        }];
    }else {
        [self removeFromSuperview];
    }
}

#pragma mark Transitions/动画效果

- (void)transitionInCompletion:(void(^)(void))completion{
    
    switch (self.transitionStyle) {
        case KKAlertViewTransitionStyleSlideFromBottom:{
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.bounds.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:1.0 animations:^{
                self.containerView.frame = originalRect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleSlideFromTop:{
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:animationTime animations:^{
                self.containerView.frame = originalRect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleFade:{
            self.containerView.alpha = 0;
            [UIView animateWithDuration:animationTime animations:^{
                                 self.containerView.alpha = 1;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleBounce:{
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = animationTime;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
        }
            break;
        case KKAlertViewTransitionStyleDropDown:{
            
            CGFloat y = self.containerView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"dropdown"];
        }
            break;
        default:
            break;
    }
}

- (void)transitionOutCompletion:(void(^)(void))completion{
    
    switch (self.transitionStyle) {
        case KKAlertViewTransitionStyleSlideFromBottom:{
            CGRect rect = self.containerView.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.frame = rect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleSlideFromTop:{
            CGRect rect = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.frame = rect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleFade:{
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.alpha = 0;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        case KKAlertViewTransitionStyleBounce:{
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];
            
            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
            break;
        case KKAlertViewTransitionStyleDropDown:
        {
            CGPoint point = self.containerView.center;
            point.y += self.bounds.size.height;
            
            [UIView animateWithDuration:animationTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.center = point;
                CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                self.containerView.transform = CGAffineTransformMakeRotation(angle);
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
            break;
        default: {
            if (completion) {
                completion();
            }
        }
            break;
    }
}

- (void)resetTransition{
    [self.containerView.layer removeAllAnimations];
}

#pragma mark CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    if (_isAutoHidden) {
//        [self dismissAnimated:YES];
//    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
}

@end
