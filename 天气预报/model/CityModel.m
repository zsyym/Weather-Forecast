//
//  CityModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CityModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    CityModel* model = [[CityModel alloc] init];
    model.cityName = dict[@"name"] ?: @"";
    model.region = dict[@"region"] ?: @"";
    model.country = dict[@"country"] ?: @"";
    model.cityLat = [dict[@"lat"] doubleValue];
    model.cityLon = [dict[@"lon"] doubleValue];
    return model;
}
-(NSString *)displayFullName {
    if (self.region.length > 0) {
        return [NSString stringWithFormat:@"%@, %@, %@", self.cityName, self.region, self.country];
    }
    return [NSString stringWithFormat:@"%@, %@", self.cityName, self.country];
}

@end

NS_ASSUME_NONNULL_END
