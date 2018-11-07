//
//  HZBottomView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/4.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"

@class HZBottomAction;
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HZBottomViewStyleCanel,//带有取消按钮
    HZBottomViewStyleNormal,//不带有取消按钮
} HZBottomViewStyle;

@interface HZBottomView : HZPopUpView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) HZBottomViewStyle style;
- (void)addAction:(HZBottomAction *)action;
- (instancetype)initWithTitle:(NSString *)title style:(HZBottomViewStyle)style;
@end


typedef void(^OnLickAction)(void);
@interface HZBottomAction : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) OnLickAction hander;

+ (instancetype)modelWithImage:(UIImage *)image title:(NSString *)title hander:(OnLickAction)hander ;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
