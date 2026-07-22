//
//  DetailCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "DetailCell.h"
#import <Masonry/Masonry.h>
@implementation DetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        self.glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.glassView.layer.cornerRadius = 15;
        self.glassView.clipsToBounds = YES;
        [self.contentView addSubview:self.glassView];
        [self.glassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.title = [[UILabel alloc] init];
        self.title.textColor = [UIColor whiteColor];
        self.title.font = [UIFont systemFontOfSize:16];
        [self.glassView.contentView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
        }];
        
        self.data = [[UILabel alloc] init];
        self.data.textColor = [UIColor whiteColor];
        self.data.font = [UIFont systemFontOfSize:30];
        [self.glassView.contentView addSubview:self.data];
        [self.data mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.top.equalTo(self.title.mas_bottom).offset(10);
        }];
        
        self.imageview = [[UIImageView alloc] init];
        self.imageview.contentMode = UIViewContentModeScaleAspectFill;
        [self.glassView.contentView addSubview:self.imageview];
        [self.imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.data.mas_bottom).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.width.mas_equalTo(40);
        }];
        
        self.dataDescription = [[UILabel alloc] init];
        self.dataDescription.textColor = [UIColor whiteColor];
        self.dataDescription.font = [UIFont systemFontOfSize:16];
        [self.glassView.contentView addSubview:self.dataDescription];
        [self.dataDescription mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.title);
        }];
    }
    return self;
}

@end
