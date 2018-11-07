//
//  HZAlertView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/3.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"

NS_ASSUME_NONNULL_BEGIN
@class HZAlertAction;

@interface HZAlertModel : NSObject
///标题
@property (nonatomic, copy) NSString *title;
///详情
@property (nonatomic, copy) NSString *detailTitle;
///标题文字颜色
@property (nonatomic, strong) UIColor *titleColor;
///详情文字颜色
@property (nonatomic, strong) UIColor *detailTitleColor;
///标题文字大小
@property (nonatomic, strong) UIFont *titleFont;
///详情文字大小
@property (nonatomic, strong) UIFont *detailTitleFont;

/**
 初始化方法，默认标题颜色blackcolor 默认字体大小17 ， 默认详情颜色darkGrayColor 默认字体大小15

 @param title 标题
 @param detailTitle 详情
 @return HZAlertModel
 */
- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle;

/**
 初始化方法

 @param title 标题
 @param detailTitle 详情
 @param titleFont 标题字体大小
 @param detailTitleFont 详情字体大小
 @param titleColor 标题文字颜色
 @param detailTitleColor 标题详情文字颜色
 @return HZAlertModel
 */
- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle titleFont:(UIFont *)titleFont detailTitleFont:(UIFont *)detailTitleFont titleColor:(UIColor *)titleColor detailTitleColor:(UIColor *)detailTitleColor;


/**
 类方法，默认标题颜色blackcolor 默认字体大小17 ， 默认详情颜色darkGrayColor 默认字体大小15

 @param title 标题
 @param detailTitle 详情
 @return HZAlertModel
 */
+ (instancetype)modelWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle;

/**
 类方法
 
 @param title 标题
 @param detailTitle 详情
 @param titleFont 标题字体大小
 @param detailTitleFont 详情字体大小
 @param titleColor 标题文字颜色
 @param detailTitleColor 标题详情文字颜色
 @return HZAlertModel
 */
+ (instancetype)modelWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle titleFont:(UIFont *)titleFont detailTitleFont:(UIFont *)detailTitleFont titleColor:(UIColor *)titleColor detailTitleColor:(UIColor *)detailTitleColor;
@end

@interface HZAlertView : HZPopUpView
@property (nonatomic, strong) HZAlertModel *alertModel;
///添加交互按钮
- (void)addAction:(HZAlertAction *)action;

- (instancetype)initWithModel:(HZAlertModel *)model;
@end



typedef void(^AlertAction)(void);
@interface HZAlertAction : NSObject
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) AlertAction action;


/**
 HZAlertAction，按钮默认黑色，字体15

 @param title 按钮文字
 @param handler 回调
 @return HZAlertAction
 */
+ (HZAlertAction *)actionWithTitle:(NSString *)title  handler:(AlertAction)handler;


/**
 HZAlertAction，按钮默认字体15

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @param handler 回调
 @return HZAlertAction
 */
+ (HZAlertAction *)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(AlertAction)handler;


/**
 HZAlertAction

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @param font 按钮文字字体
 @param handler 回调
 @return HZAlertAction
 */
+ (HZAlertAction *)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font handler:(void (^)(void))handler;


/**
 初始化方法

 @param title 按钮文字
 @return HZAlertAction
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 初始化方法

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @return HZAlertAction
 */
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;


/**
 初始化方法

 @param title 按钮文字
 @param titleColor 按钮文字颜色
 @param font 按钮字体
 @return HZAlertAction
 */
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
