//
//  HourWeatherModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourWeatherModel : NSObject

@property (nonatomic, copy) NSString *time;          // "2026-07-15 14:00"
@property (nonatomic, assign) double tempC;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *conditionCode;
@property (nonatomic, copy) NSString *conditionText;
@property (nonatomic, assign) NSInteger chanceOfRain;   // 降水概率 0-100

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
- (NSString *)displayHourString:(NSString*)time;
@end

NS_ASSUME_NONNULL_END
