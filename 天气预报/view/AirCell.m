//
//  AirCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "AirCell.h"
#import <Masonry/Masonry.h>
@implementation AirCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 15;
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        self.glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.glassView.layer.cornerRadius = 15;
        self.glassView.clipsToBounds = YES;
        [self.contentView addSubview:self.glassView];
        [self.glassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.aqiIcon = [[UIImageView alloc] init];
        self.levelLabel = [[UILabel alloc] init];
        self.levelLabel.textColor = [UIColor whiteColor];
        self.pm2_5Label = [[UILabel alloc] init];
        self.pm2_5Label.textColor = [UIColor whiteColor];
        self.pm10Label = [[UILabel alloc] init];
        self.pm10Label.textColor = [UIColor whiteColor];
        self.coLabel = [[UILabel alloc] init];
        self.coLabel.textColor = [UIColor whiteColor];
        self.no2Label = [[UILabel alloc] init];
        self.no2Label.textColor = [UIColor whiteColor];
        self.so2Label = [[UILabel alloc] init];
        self.so2Label.textColor = [UIColor whiteColor];
        self.o3Label = [[UILabel alloc] init];
        self.o3Label.textColor = [UIColor whiteColor];
        self.levelLabel.font = [UIFont systemFontOfSize:20];
        UIStackView* titleStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.aqiIcon, self.levelLabel]];
        titleStack.axis = UILayoutConstraintAxisHorizontal;
        titleStack.spacing = 10;
        [self.glassView.contentView addSubview:titleStack];
        [titleStack mas_makeConstraints: ^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(10);
        }];
        [self.aqiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(25);
        }];
        UIStackView *row1 =[[UIStackView alloc] initWithArrangedSubviews:@[self.pm2_5Label,self.pm10Label]];
        row1.axis = UILayoutConstraintAxisHorizontal;
        row1.distribution = UIStackViewDistributionFillEqually;
        UIStackView *row2 = [[UIStackView alloc] initWithArrangedSubviews:@[self.coLabel,self.no2Label]];
        row2.axis = UILayoutConstraintAxisHorizontal;
        row2.distribution = UIStackViewDistributionFillEqually;
        UIStackView *row3 = [[UIStackView alloc] initWithArrangedSubviews:@[self.so2Label,self.o3Label]];
        row3.axis = UILayoutConstraintAxisHorizontal;
        row3.distribution = UIStackViewDistributionFillEqually;
        UIStackView *mainStack = [[UIStackView alloc] initWithArrangedSubviews:@[row1, row2, row3]];
        mainStack.axis = UILayoutConstraintAxisVertical;
        mainStack.spacing = 15;
        [self.glassView.contentView addSubview:mainStack];
        [mainStack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleStack.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}
-(void)setModel:(AirQualityModel *)model {
    _model = model;
    self.levelLabel.text = [model levelDescription:model.usEpaIndex];
    self.pm2_5Label.text = [NSString stringWithFormat:@"PM2.5 %.1f",model.pm2_5];
    self.pm10Label.text = [NSString stringWithFormat:@"PM10 %.1f",model.pm10];
    self.coLabel.text = [NSString stringWithFormat:@"CO %.1f",model.co];
    self.no2Label.text = [NSString stringWithFormat:@"NO2 %.1f",model.no2];
    self.so2Label.text = [NSString stringWithFormat:@"SO2 %.1f",model.so2];
    self.o3Label.text = [NSString stringWithFormat:@"O3 %.1f",model.o3];
    if ([self.levelLabel.text isEqualToString:@"优"] || [self.levelLabel.text isEqualToString:@"良"]) {
        UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
        UIImage* image = [[UIImage systemImageNamed:@"aqi.low"] imageByApplyingSymbolConfiguration:config];
        self.aqiIcon.image = image;
    }
    if ([self.levelLabel.text isEqualToString:@"轻度污染"] || [self.levelLabel.text isEqualToString:@"中度污染"]) {
        UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
        UIImage* image = [[UIImage systemImageNamed:@"aqi.medium"] imageByApplyingSymbolConfiguration:config];
        self.aqiIcon.image = image;
    }
    if ([self.levelLabel.text isEqualToString:@"重度污染"] || [self.levelLabel.text isEqualToString:@"严重污染"]) {
        UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
        UIImage* image = [[UIImage systemImageNamed:@"aqi.high"] imageByApplyingSymbolConfiguration:config];
        self.aqiIcon.image = image;
    }
    if ([self.levelLabel.text isEqualToString:@"未知"]) {
        UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
        UIImage* image = [[UIImage systemImageNamed:@"aqi.medium"] imageByApplyingSymbolConfiguration:config];
        self.aqiIcon.image = image;
    }
    self.levelLabel.text = [@"AQI - " stringByAppendingString:[model levelDescription:model.usEpaIndex]];
}
@end
