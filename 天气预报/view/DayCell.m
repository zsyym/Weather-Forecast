//
//  DayCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "DayCell.h"
#import <Masonry/Masonry.h>
@implementation DayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.weekDay = [[UILabel alloc] init];
        self.weekDay.textColor = [UIColor whiteColor];
        self.weekDay.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.weekDay];
        
        self.icon = [[UIImageView alloc] init];
        self.icon.clipsToBounds = YES;
        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.icon];
        self.chanceOfRain = [[UILabel alloc] init];
        self.chanceOfRain.textColor = [UIColor systemBlueColor];
        self.chanceOfRain.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.chanceOfRain];
        self.minTempC = [[UILabel alloc] init];
        self.minTempC.textColor = [UIColor whiteColor];
        self.minTempC.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.minTempC];
        self.maxTempC = [[UILabel alloc] init];
        self.maxTempC.textColor = [UIColor whiteColor];
        self.maxTempC.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.maxTempC];
        UIView* tempLine = [[UIView alloc] init];
        tempLine.backgroundColor = [UIColor systemOrangeColor];
        tempLine.layer.cornerRadius = 2.5;
        [self.contentView addSubview:tempLine];
        [self.weekDay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.width.mas_equalTo(70);
            make.centerY.equalTo(self.contentView);
        }];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.weekDay.mas_right);
            make.width.height.mas_equalTo(30);
            make.centerY.equalTo(self.contentView);
        }];

        [self.minTempC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(40);
            make.width.mas_equalTo(40);
            make.centerY.equalTo(self.contentView);
        }];
        [tempLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.minTempC.mas_right).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(4);
            make.centerY.equalTo(self.contentView);
        }];
        [self.chanceOfRain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.icon);
            make.top.equalTo(self.icon.mas_bottom).offset(2);
        }];
        [self.maxTempC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempLine.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)setModel:(DailyForecastModel *)model {
    _model = model;
    self.weekDay.text = [model weekdayWithDate:model.date];
    self.maxTempC.text = [[NSString stringWithFormat:@"%.0f",model.maxTempC] stringByAppendingString:@"°"];
    self.minTempC.text = [[NSString stringWithFormat:@"%.0f",model.minTempC] stringByAppendingString:@"°"];
    self.chanceOfRain.text = [[NSString stringWithFormat:@"%ld",model.chanceOfRain] stringByAppendingString:@"%"];
    if (model.chanceOfRain == 0) {
        self.chanceOfRain.hidden = YES;
    }
    UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImage* image = [[UIImage systemImageNamed:model.icon] imageByApplyingSymbolConfiguration:config];
    self.icon.image = image;
}
                                             
                                             
                                            
                                            
@end
