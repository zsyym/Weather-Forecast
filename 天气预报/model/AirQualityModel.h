//
//  AirQualityModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirQualityModel : NSObject

@property (nonatomic, assign) double pm2_5;
@property (nonatomic, assign) double pm10;
@property (nonatomic, assign) double co;
@property (nonatomic, assign) double no2;
@property (nonatomic, assign) double o3;
@property (nonatomic, assign) double so2;
@property (nonatomic, assign) NSInteger usEpaIndex;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
- (NSString *)levelDescription:(NSInteger) usEpaIndex;

@end

NS_ASSUME_NONNULL_END
