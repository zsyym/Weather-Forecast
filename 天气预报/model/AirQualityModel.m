//
//  AirQualityModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "AirQualityModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AirQualityModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    AirQualityModel* model = [[AirQualityModel alloc] init];
    model.pm2_5 = [dict[@"pm2_5"] doubleValue];
    model.pm10 = [dict[@"pm10"] doubleValue];
    model.so2 = [dict[@"so2"] doubleValue];
    model.no2 = [dict[@"no2"] doubleValue];
    model.o3 = [dict[@"o3"] doubleValue];
    model.co = [dict[@"co"] doubleValue];
    model.usEpaIndex = [dict[@"us-epa-index"] integerValue];
    return model;
}
-(NSString *)levelDescription:(NSInteger)usEpaIndex{
    switch (usEpaIndex) {
        case 1:
            return @"优";
        case 2:
            return @"良";
        case 3:
            return @"轻度污染";
        case 4:
            return @"中度污染";
        case 5:
            return @"重度污染";
        case 6:
            return @"严重污染";
        default:
            return @"未知";
    }
}

@end

NS_ASSUME_NONNULL_END
