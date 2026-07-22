//
//  HeaderCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "HeaderCell.h"
#import <Masonry/Masonry.h>
@implementation HeaderCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.cityName = [[UILabel alloc] init];
        self.cityName.font = [UIFont systemFontOfSize:34];
        self.cityName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cityName];
        [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
        }];
        
        self.currentTemp = [[UILabel alloc] init];
        self.currentTemp.font = [UIFont systemFontOfSize:50];
        self.currentTemp.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.currentTemp];
        [self.currentTemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cityName.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView);
        }];
        
        self.maxAndMinTemp = [[UILabel alloc] init];
        self.maxAndMinTemp.textColor = [UIColor whiteColor];
        self.maxAndMinTemp.font = [UIFont systemFontOfSize:30];
        [self.contentView addSubview:self.maxAndMinTemp];
        [self.maxAndMinTemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.currentTemp.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView);
        }];
        
        self.conditionText = [[UILabel alloc] init];
        self.conditionText.textColor = [UIColor whiteColor];
        self.conditionText.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.conditionText];
        [self.conditionText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.maxAndMinTemp.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)setModel:(CurrentWeatherModel *)model {
    _model = model;
    self.cityName.text = model.cityName;
    self.currentTemp.text = [NSString stringWithFormat:@"%.0f°", model.currentTemp];
    self.maxAndMinTemp.text = [NSString stringWithFormat: @"最高%.0f° 最低%.0f°", model.maxTemp, model.minTemp];
    self.conditionText.text = model.conditionText;
}

@end
