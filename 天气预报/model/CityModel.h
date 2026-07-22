//
//  CityModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : NSObject

@property(nonatomic, copy) NSString* cityName;
@property(nonatomic, copy) NSString* region;
@property(nonatomic, copy) NSString* country;
@property(nonatomic, assign) double cityLat;
@property(nonatomic, assign) double cityLon;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(NSString *)displayFullName;
@end

NS_ASSUME_NONNULL_END
