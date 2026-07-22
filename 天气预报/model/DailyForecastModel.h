//
//  DailyForecastModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <Foundation/Foundation.h>
#import "AirQualityModel.h"
#import "HourWeatherModel.h"
#import "AirQualityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DailyForecastModel : NSObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) double maxTempC;
@property (nonatomic, assign) double minTempC;
@property (nonatomic, assign) double avgTempC;
@property (nonatomic, assign) NSInteger chanceOfRain;
@property (nonatomic, copy) NSString *conditionText;
@property (nonatomic, copy) NSString *conditionCode;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;
@property (nonatomic, strong, nullable) AirQualityModel *airQuality;
@property (nonatomic, strong) NSArray<HourWeatherModel *> *hours;

+(instancetype) modelWithDictionary:(NSDictionary*)dict;
-(NSString*) weekdayWithDate:(NSString*) date;
@end

NS_ASSUME_NONNULL_END
