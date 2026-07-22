//
//  SavedCityStore.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "SavedCityStore.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SavedCityStore

+(NSArray *)savedCities {
    NSArray *cityDictArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"];
    NSMutableArray *cities = [NSMutableArray array];
    for (NSDictionary *dict in cityDictArray) {
        CityModel *city = [[CityModel alloc] init];
        city.cityLat = [dict[@"cityLat"] doubleValue];
        city.cityLon = [dict[@"cityLon"] doubleValue];
        city.cityName = dict[@"cityName"];
        [cities addObject:city];
    }
    if (cities.count == 0) {
        CityModel *city = [[CityModel alloc] init];
        city.cityLat = 39.9042;
        city.cityLon = 116.4074;
        city.cityName = @"北京";
        [cities addObject:city];
    }
    return cities;
}
+(void)removeCity:(CityModel *)city {
    NSMutableArray *cityArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"] mutableCopy];
    if (!cityArray) {
        return;
    }
    for (NSDictionary *dict in [cityArray copy]) {
        if ([dict[@"cityName"] isEqualToString:city.cityName]) {
            [cityArray removeObject:dict];
            break;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:cityArray forKey:@"savedCities"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)addCity:(CityModel *)city {
    NSMutableArray* cityArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"] mutableCopy];
    if (!cityArray) {
        cityArray = [NSMutableArray array];
    }
    for (NSDictionary* dict in cityArray) {
        if ([dict[@"cityName"] isEqualToString:city.cityName]) {
            return;
        }
    }
    NSDictionary* dict = @{@"cityLat" : @(city.cityLat) ?: @"", @"cityLon" :@(city.cityLon) ?:@"", @"cityName" : city.cityName ?: @""};
    [cityArray addObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:cityArray forKey:@"savedCities"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}
+(BOOL)isAdd:(CityModel *)city{
    NSMutableArray* cityArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"savedCities"] mutableCopy];
    if (!cityArray) {
        cityArray = [NSMutableArray array];
    }
    for (NSDictionary* dict in cityArray) {
        if ([dict[@"cityName"] isEqualToString:city.cityName]) {
            return YES;
        }
    }
    return NO;
}
@end

NS_ASSUME_NONNULL_END
