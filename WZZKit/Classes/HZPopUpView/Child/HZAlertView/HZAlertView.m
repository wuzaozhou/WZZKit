//
//  HZAlertView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/3.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZAlertView.h"
#import <Masonry/Masonry.h>

@implementation HZAlertModel

- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle {
    return [self initWithTitle:title detailTitle:detailTitle titleFont:HZPopViewFont(17) detailTitleFont:HZPopViewFont(15) titleColor:[UIColor blackColor] detailTitleColor:[UIColor darkGrayColor]];
}

- (instancetype)initWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle titleFont:(UIFont *)titleFont detailTitleFont:(UIFont *)detailTitleFont titleColor:(UIColor *)titleColor detailTitleColor:(UIColor *)detailTitleColor {
    self = [super init];
    if (self) {
        _title = title;
        _detailTitle = detailTitle;
        _titleFont = titleFont;
        _detailTitleFont = detailTitleFont;
        _titleColor = titleColor;
        _detailTitleColor = detailTitleColor;
    }
    return self;
}

+ (instancetype)modelWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle {
    HZAlertModel *model = [[HZAlertModel alloc] initWithTitle:title detailTitle:detailTitle];
    return model;
}

+ (instancetype)modelWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle titleFont:(UIFont *)titleFont detailTitleFont:(UIFont *)detailTitleFont titleColor:(UIColor *)titleColor detailTitleColor:(UIColor *)detailTitleColor {
    HZAlertModel *model = [[HZAlertModel alloc] initWithTitle:title detailTitle:detailTitle titleFont:titleFont detailTitleFont:detailTitleFont titleColor:titleColor detailTitleColor:detailTitleColor];
    return model;
}

@end

@interface HZAlertView ()
@property (nonatomic, strong) NSMutableArray<HZAlertAction *> *actionArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@end

@implementation HZAlertView


- (instancetype)initWithModel:(HZAlertModel *)model {
    self = [super initWithAnimationStyle:KKAlertViewTransitionStyleDropDown backgrounpStyle:KKAlertViewBackgroundStyleTranslucent isAutoHidden:NO];
    if (self) {
        [self setAlertModel:model];
    }
    return self;
}

///给containerview添加子视图
- (void)setupContainerSubViews {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [self.containerView addSubview:_titleLabel];
    
    _detailTitleLabel = [[UILabel alloc] init];
    _detailTitleLabel.numberOfLines = 0;
    _detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    _detailTitleLabel.textColor = [UIColor darkGrayColor];
    [self.containerView addSubview:_detailTitleLabel];
}

//设置containerview的属性
- (void)setupContainerViewAttributes {
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.layer.cornerRadius = 10;
    self.containerView.layer.masksToBounds = YES;
}

- (void)layoutContainerViewSubViews {
    [super layoutContainerViewSubViews];
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat width = 300;
    CGFloat height = 0;
    CGFloat margin = 10;
    CGFloat titleWidth = width-margin*2;
    if (_alertModel.title!=nil && ![_alertModel.title isEqualToString:@""] && _alertModel.title!= NULL) {
        CGSize size = [_alertModel.title boundingRectWithSize:CGSizeMake(titleWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _titleLabel.font} context:nil].size;
        _titleLabel.frame = CGRectMake(margin, margin, titleWidth, size.height);
        height += margin+size.height;
    }
    
    if (_alertModel.detailTitle!=nil && ![_alertModel.detailTitle isEqualToString:@""] && _alertModel.detailTitle!= NULL) {
        CGFloat detailHeight = [_alertModel.detailTitle boundingRectWithSize:CGSizeMake(titleWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _detailTitleLabel.font} context:nil].size.height+margin*2;
        _detailTitleLabel.frame = CGRectMake(margin, height+margin, titleWidth, detailHeight);
        height += margin+detailHeight;
    }
    height += margin;
    self.actionArray.firstObject.line.frame = CGRectMake(0, height, width, 1);
    CGFloat btnHeight = 44;
    if (self.actionArray.count == 1) {
        self.actionArray.firstObject.btn.frame = CGRectMake(0, height, width, btnHeight);
        height += btnHeight;
    }else if (self.actionArray.count == 2) {
        self.actionArray.firstObject.btn.frame = CGRectMake(0, height, width/2.0, btnHeight);
        self.actionArray.lastObject.line.frame = CGRectMake(width/2.0, height, 1, height);
        self.actionArray.lastObject.btn.frame = CGRectMake(width/2.0, height, width/2.0, btnHeight);
        height += btnHeight;
    }else {
        [self.actionArray enumerateObjectsUsingBlock:^(HZAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.btn.frame = CGRectMake(0, height+btnHeight*idx, width, btnHeight);
            if (idx != 0 && idx != self.actionArray.count) {
                obj.line.frame = CGRectMake(0,  height+btnHeight*idx, width, 1);
            }
        }];
        height += btnHeight*self.actionArray.count;
    }
    self.containerView.frame = CGRectMake((screenWidth-width)/2.0, (screenHeight-height)/2.0, width, height);
}

- (void)addAction:(HZAlertAction *)action {
    action.btn.tag = self.actionArray.count;
    
    [self.actionArray addObject:action];
    [action.btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:action.btn];
    [self.containerView.layer addSublayer:action.line];
    [self layoutContainerViewSubViews];
    
}

- (void)onClickBtn:(UIButton *)btn {
    [self dismissAnimated:YES];
    HZAlertAction *alertAction = self.actionArray[btn.tag];
    alertAction.action ? alertAction.action() : nil;
}


- (void)setAlertModel:(HZAlertModel *)alertModel {
    _alertModel = alertModel;
    
    _titleLabel.text = alertModel.title;
    _detailTitleLabel.text = alertModel.detailTitle;
    
    _titleLabel.font = alertModel.titleFont ? alertModel.titleFont : HZPopViewFont(17) ;
    _detailTitleLabel.font = alertModel.detailTitleFont ? alertModel.detailTitleFont : HZPopViewFont(15);
    
    _titleLabel.textColor = alertModel.titleColor ? alertModel.titleColor : [UIColor blackColor];
    _detailTitleLabel.textColor = alertModel.detailTitleColor ? alertModel.detailTitleColor : [UIColor darkGrayColor];
    
    [self layoutContainerViewSubViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self layoutContainerViewSubViews];
}


- (NSMutableArray<HZAlertAction *> *)actionArray {
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}
@end


@interface HZAlertAction ()

@end

@implementation HZAlertAction

+ (HZAlertAction *)actionWithTitle:(NSString *)title  handler:(AlertAction)handler {
    HZAlertAction *action = [HZAlertAction actionWithTitle:title titleColor:nil font:nil handler:handler];
    return action;
}

+ (HZAlertAction *)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(AlertAction)handler {
    HZAlertAction *action = [HZAlertAction actionWithTitle:title titleColor:titleColor font:nil handler:handler];
    return action;
}

+ (HZAlertAction *)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font handler:(void (^)(void))handler {
    HZAlertAction *action = [[HZAlertAction alloc] initWithTitle:title titleColor:titleColor font:font];
    titleColor ? (action.titleColor = titleColor) : nil;
    font ? (action.font = font) : nil;
    return action;
}

- (instancetype)initWithTitle:(NSString *)title {
    return [self initWithTitle:title titleColor:nil font:nil];
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    return [self initWithTitle:title titleColor:titleColor font:nil];
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font {
    if (self = [super init]) {
        _title = title;
        _titleColor = titleColor ? titleColor : [UIColor blackColor];
        _font = font ? font : HZPopViewFont(15);
    }
    return self;
}



- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:_title forState:UIControlStateNormal];
        [_btn setTitleColor:_titleColor forState:UIControlStateNormal];
        _btn.titleLabel.font = _font;
        _btn.titleLabel.font = HZPopViewFont(15);
    }
    return _btn;
}

- (CALayer *)line {
    if (_line == nil) {
        _line = [CALayer layer];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }
    return _line;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.btn setTitleColor:titleColor forState:UIControlStateNormal];
    
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.btn.titleLabel.font = font;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.btn setTitle:title forState:UIControlStateNormal];
}

-(void)dealloc {
    NSLog(@"=============");
}

@end

