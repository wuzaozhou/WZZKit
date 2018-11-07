//
//  HZUpgradeVersionView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/2.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"



NS_ASSUME_NONNULL_BEGIN

@interface HZUpgradeVersionView : HZPopUpView
@property (nonatomic, strong, readonly) UIImageView *imageView;//背景图片
@property (nonatomic, strong, readonly) UILabel *titleLabel;//标题
@property (nonatomic, strong, readonly) UILabel *tipsLabel;//提示内容
@property (nonatomic, strong, readonly) UIButton *updateButton;//升级按钮
@property (nonatomic, strong, readonly) UIButton *dnrButton;//暂不更新按钮
@property (nonatomic, copy) NSString *updateMessage;
@end

NS_ASSUME_NONNULL_END
