//
//  totalWeatherModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/18.
//

#import <Foundation/Foundation.h>
#import "CurrentWeatherModel.h"
#import "DailyForecastModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface totalWeatherModel : NSObject

@property(nonatomic, strong) CurrentWeatherModel *currentModel;
@property(nonatomic, strong) NSMutableArray<DailyForecastModel *> *forecastArray;
+(instancetype)modelWithDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
