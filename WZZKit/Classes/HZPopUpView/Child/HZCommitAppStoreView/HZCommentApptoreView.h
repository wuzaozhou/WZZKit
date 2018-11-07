//
//  HZCommentApptoreView.h
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/3.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZPopUpView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HZCommentApptoreView : HZPopUpView
@property (nonatomic, strong, readonly) UIButton *closeBtn;
@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIButton *complaintsBtn;//吐槽按钮
@property (nonatomic, strong, readonly) UIButton *encourageBtn;//鼓励按钮

@property (nonatomic, copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
