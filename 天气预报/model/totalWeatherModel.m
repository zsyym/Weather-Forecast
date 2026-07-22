//
//  totalWeatherModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/18.
//

#import "totalWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation totalWeatherModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    totalWeatherModel* model = [[totalWeatherModel alloc] init];
    model.currentModel = [CurrentWeatherModel modelWithDictionary:dict];
    model.forecastArray = [NSMutableArray array];
    NSArray* array = dict[@"forecast"][@"forecastday"];
    for (NSDictionary* dictionary in array) {
        DailyForecastModel* forecastModel = [DailyForecastModel modelWithDictionary:dictionary];
        [model.forecastArray addObject:forecastModel];
    }
    return model;
}

@end

NS_ASSUME_NONNULL_END
