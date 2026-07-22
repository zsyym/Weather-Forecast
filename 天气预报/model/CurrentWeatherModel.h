//
//  CurrentWeatherModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <Foundation/Foundation.h>
#import "AirQualityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CurrentWeatherModel : NSObject

@property (nonatomic, copy) NSString *cityName;      // 城市名
@property (nonatomic, copy) NSString *localTime;      // 当地时间，字符串格式"2026-07-15 14:30"
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) double currentTemp;      // 目前温度（摄氏度）
@property (nonatomic, assign) double maxTemp;           // 今日最高温度
@property (nonatomic, assign) double minTemp;           // 今日最低温度
@property (nonatomic, copy) NSString *conditionCode;
@property (nonatomic, copy) NSString *conditionText;
@property (nonatomic, assign) double feelsLikeC;    //体感
@property (nonatomic, assign) double windKph;       //风速
@property (nonatomic, assign) double precipMm;      //降水
@property (nonatomic, assign) double visKm;         //能见度
@property (nonatomic, assign) double pressureMb;    //气压
@property (nonatomic, assign) double uvIndex;//紫外线
@property (nonatomic, assign) NSInteger humidity;//湿度
@property (nonatomic, strong, nullable) AirQualityModel *airQuality;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
