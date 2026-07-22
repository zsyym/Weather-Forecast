//
//  HourItemCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/18.
//

#import "HourItemCell.h"
#import <Masonry/Masonry.h>
@implementation HourItemCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.hour = [[UILabel alloc] init];
        self.hour.font = [UIFont systemFontOfSize:14];
        self.hour.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.hour];
        [self.hour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(5);
        }];
        
        self.icon = [[UIImageView alloc] init];
        self.icon.clipsToBounds = YES;
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hour.mas_bottom).offset(8);
            make.centerX.equalTo(self.contentView);
            make.width.height.mas_equalTo(28);
        }];
        
        self.chanceOfRain = [[UILabel alloc] init];
        self.chanceOfRain.textColor = [UIColor systemBlueColor];
        self.chanceOfRain.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.chanceOfRain];
        [self.chanceOfRain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.icon.mas_bottom).offset(5);
        }];
        
        self.tempC = [[UILabel alloc] init];
        self.tempC.textColor = [UIColor whiteColor];
        self.tempC.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.tempC];
        [self.tempC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
    }
    return self;
}
-(void)setModel:(HourWeatherModel *)model {
    _model = model;
    self.hour.text = [model displayHourString:model.time];
    self.tempC.text = [[NSString stringWithFormat:@"%.0f",model.tempC] stringByAppendingString:@"°"];
    self.chanceOfRain.text = [[NSString stringWithFormat:@"%ld",model.chanceOfRain] stringByAppendingString:@"%"];
    if (model.chanceOfRain == 0) {
        self.chanceOfRain.hidden = YES;
    }
    UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImage* image = [[UIImage systemImageNamed:model.icon] imageByApplyingSymbolConfiguration:config];
    self.icon.image = image;
}
@end
