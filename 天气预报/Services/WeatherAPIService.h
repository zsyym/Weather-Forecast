//
//  WeatherAPIService.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <Foundation/Foundation.h>
#import "CurrentWeatherModel.h"
#import "CityModel.h"
#import "totalWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeatherAPIService : NSObject

+(instancetype)sharedManager;
-(void)fetchCurrentWeatherWithCity:(NSString*)latLonQuery completion:(void (^)(CurrentWeatherModel * _Nullable model, NSError * _Nullable error)) completion;
-(void)fetchTotalWeatherWithCity:(NSString*)latLonQuery completion:(void (^)(totalWeatherModel * _Nullable model, NSError * _Nullable error)) completion;
-(void)searchCityWithKeyword:(NSString*)keyword completion:(void (^)(NSArray<CityModel *> * _Nullable cities, NSError * _Nullable error)) completion;

@end

NS_ASSUME_NONNULL_END
