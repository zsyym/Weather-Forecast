//
//  CurrentWeatherModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "CurrentWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CurrentWeatherModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    CurrentWeatherModel* model = [[CurrentWeatherModel alloc] init];
    //location 城市名+当地时间
    NSDictionary *locationDict = dict[@"location"];
    if ([locationDict isKindOfClass:[NSDictionary class]]) {
        model.cityName = locationDict[@"name"] ?: @"";
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        model.localTime = locationDict[@"localtime"] ?: @"";
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]; // 避免某些地区把24小时制解析错
        NSDate *date = [formatter dateFromString:model.localTime];
        // 转换成只显示"时:分"
        NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
        displayFormatter.dateFormat = @"HH:mm";
        model.time = [displayFormatter stringFromDate:date];
    }
    //current目前温度
    NSDictionary *currentDict = dict[@"current"];
    if ([currentDict isKindOfClass:[NSDictionary class]]) {
        model.currentTemp = [currentDict[@"temp_c"] doubleValue];
        model.windKph = [currentDict[@"wind_kph"] doubleValue];
        model.pressureMb = [currentDict[@"pressure_mb"] doubleValue];
        model.precipMm = [currentDict[@"precip_mm"] doubleValue];
        model.humidity = [currentDict[@"humidity"] doubleValue];
        model.feelsLikeC = [currentDict[@"fellslike_c"] doubleValue];
        model.uvIndex = [currentDict[@"uv"] doubleValue];
        model.visKm = [currentDict[@"vis_km"] doubleValue];
        NSDictionary* conditionDict = currentDict[@"condition"];
        if ([conditionDict isKindOfClass:[NSDictionary class]]) {
            model.conditionCode = conditionDict[@"code"];
            model.conditionText = conditionDict[@"text"];
        }
    }
    NSDictionary *forecastDict = dict[@"forecast"];
    if ([forecastDict isKindOfClass:[NSDictionary class]]) {
        NSArray *forecastDayArray = forecastDict[@"forecastday"];
        if ([forecastDayArray isKindOfClass:[NSArray class]] && forecastDayArray.count > 0) {
            NSDictionary *firstDay = forecastDayArray.firstObject;
            NSDictionary *dayDict = firstDay[@"day"];
            if ([dayDict isKindOfClass:[NSDictionary class]]) {
                model.maxTemp = [dayDict[@"maxtemp_c"] doubleValue];
                model.minTemp = [dayDict[@"mintemp_c"] doubleValue];
            }
        }
    }
    return model;
}

@end

NS_ASSUME_NONNULL_END
