//
//  SavedCityStore.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SavedCityStore : NSObject

+ (NSArray *)savedCities;
+ (void)addCity:(CityModel*) city;
+ (void)removeCity:(CityModel*) city;
+ (BOOL)isAdd:(CityModel*) city;
@end

NS_ASSUME_NONNULL_END
