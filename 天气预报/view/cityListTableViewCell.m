//
//  cityListTableViewCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "cityListTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation cityListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundImage = [[UIImageView alloc] init];
        self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundImage.clipsToBounds = YES;
        [self.contentView addSubview:self.backgroundImage];
        [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        self.cityName = [[UILabel alloc] init];
        self.cityName.font = [UIFont systemFontOfSize:34];
        self.cityName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cityName];
        [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
        }];
        
        self.localTime = [[UILabel alloc] init];
        self.localTime.textColor = [UIColor whiteColor];
        self.localTime.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.localTime];
        [self.localTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cityName);
            make.top.equalTo(self.cityName.mas_bottom).offset(5);
        }];
        
        self.currentTemp = [[UILabel alloc] init];
        self.currentTemp.font = [UIFont systemFontOfSize:40];
        self.currentTemp.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.currentTemp];
        [self.currentTemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cityName);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        self.maxAndMinTemp = [[UILabel alloc] init];
        self.maxAndMinTemp.textColor = [UIColor whiteColor];
        self.maxAndMinTemp.font = [UIFont systemFontOfSize:26];
        [self.contentView addSubview:self.maxAndMinTemp];
        [self.maxAndMinTemp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.currentTemp);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        self.conditionText = [[UILabel alloc] init];
        self.conditionText.textColor = [UIColor whiteColor];
        self.conditionText.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.conditionText];
        [self.conditionText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}
-(void)setModel:(CurrentWeatherModel *)model {
    _model = model;
    self.backgroundImage.image = [UIImage imageNamed:[self backgroundImageWithCode:model.conditionCode]];
    self.cityName.text = model.cityName;
    self.localTime.text = model.time;
    self.currentTemp.text = [NSString stringWithFormat:@"%.0f°", model.currentTemp];
    self.maxAndMinTemp.text = [NSString stringWithFormat: @"最高%.0f° 最低%.0f°", model.maxTemp, model.minTemp];
    self.conditionText.text = model.conditionText;
}
-(NSString *)backgroundImageWithCode:(NSString *)conditionCode {
    NSInteger code = [conditionCode integerValue];
    switch (code) {
        case 1000:
            return @"sunny";
        case 1003:
        case 1006:
        case 1009:
            return @"cloudy";
        case 1030:
        case 1135:
        case 1147:
            return @"fog";
        case 1063:
        case 1150:
        case 1153:
        case 1168:
        case 1171:
        case 1180:
        case 1183:
        case 1186:
        case 1189:
        case 1192:
        case 1195:
        case 1198:
        case 1201:
        case 1240:
        case 1243:
        case 1246:
            return @"rain";
        case 1066:
        case 1114:
        case 1117:
        case 1210:
        case 1213:
        case 1216:
        case 1219:
        case 1222:
        case 1225:
        case 1255:
        case 1258:
            return @"snow";
        case 1069:
        case 1204:
        case 1207:
        case 1249:
        case 1252:
            return @"sleet";
        case 1087:
        case 1273:
        case 1276:
            return @"thunder";
        default:
            return @"default";
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
