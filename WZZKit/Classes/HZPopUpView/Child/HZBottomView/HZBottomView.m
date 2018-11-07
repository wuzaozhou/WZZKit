//
//  HZBottomView.m
//  HZPopUpView
//
//  Created by 吴灶洲 on 2018/11/4.
//  Copyright © 2018年 吴灶洲. All rights reserved.
//

#import "HZBottomView.h"
#import "HZBottomCell.h"
#import <Masonry/Masonry.h>

@interface HZBottomView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<HZBottomAction *> *actionArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HZBottomView

- (instancetype)initWithTitle:(NSString *)title style:(HZBottomViewStyle)style {
    self = [super initWithAnimationStyle:KKAlertViewTransitionStyleNone backgrounpStyle:KKAlertViewBackgroundStyleTranslucent];
    if (self) {
        _title = title;
        _style = style;
        if (_title != nil && ![_title isEqualToString:@""] && _title != NULL) {
            _titleLabel.hidden = NO;
        }else {
            _titleLabel.hidden = NO;
        }
        [self setStyle:style];
    }
    return self;
}

/** 布局containerview的位置,就是那个看得到的视图 */
- (void)layoutContainerView {
    CGFloat height = 250;
    if ([[UIApplication sharedApplication] statusBarFrame].size.height == 44) {
        height += 34;
    }
    self.containerView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)-height, CGRectGetWidth([UIScreen mainScreen].bounds), height);
}
/** 设置containerview的属性 */
- (void)setupContainerViewAttributes {
    self.containerView.backgroundColor = [UIColor whiteColor];
}
/** 给containerview添加子视图 */
- (void)setupContainerSubViews {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.minimumLineSpacing = 15;
    _layout.minimumInteritemSpacing = 15;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    collectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[HZBottomCell class] forCellWithReuseIdentifier:@"HZBottomCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    _collectionView = collectionView;
    [self.containerView addSubview:_collectionView];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(onClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.containerView addSubview:_cancelBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.hidden = YES;
    _titleLabel.font = HZPopViewFont(16);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleLabel.text = @"分享到";
    [self.containerView addSubview:_titleLabel];
}
/** 设置子视图的frame */
- (void)layoutContainerViewSubViews {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        make.height.mas_equalTo(60);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.height.mas_equalTo(40);
        if ([[UIApplication sharedApplication] statusBarFrame].size.height == 44) {
            make.bottom.equalTo(self.containerView).offset(-34);
        }else {
            make.bottom.equalTo(self.containerView);
        }
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.bottom.mas_equalTo(self.cancelBtn.mas_top);
    }];
}

- (void)addAction:(HZBottomAction *)action {
    [self.actionArray addObject:action];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.actionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HZBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HZBottomCell" forIndexPath:indexPath];
    HZBottomAction *action = self.actionArray[indexPath.row];
    cell.imageView.image = action.image;
    cell.textLabel.text = action.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HZBottomAction *action = self.actionArray[indexPath.row];
    action.hander ? action.hander() : nil;
    [self dismissAnimated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = _style == HZBottomViewStyleNormal ? 130 : 100;
    if (self.actionArray.count <= 4) {
        NSInteger count = self.actionArray.count;
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-30-(count-1)*15)/count, height);
    }
    return CGSizeMake(70, height);
}



- (void)onClickBtn {
    [self dismissAnimated:YES];
}

- (NSMutableArray<HZBottomAction *> *)actionArray {
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_title != nil && ![_title isEqualToString:@""] && _title != NULL) {
        _titleLabel.hidden = NO;
    }else {
        _titleLabel.hidden = NO;
    }
}

- (void)setStyle:(HZBottomViewStyle)style {
    _style = style;
    if (style == HZBottomViewStyleNormal) {
        [_cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFLOAT_MIN);
        }];
        _cancelBtn.hidden = YES;
    }else {
        [_cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        _cancelBtn.hidden = NO;
    }

}

@end


@implementation HZBottomAction

+ (instancetype)modelWithImage:(UIImage *)image title:(NSString *)title hander:(OnLickAction)hander {
    HZBottomAction *model = [[HZBottomAction alloc] initWithImage:image title:title];
    if (hander) {
        model.hander = hander;
    }
    return model;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        _image = image;
        _title = title;
    }
    return self;
}



@end


