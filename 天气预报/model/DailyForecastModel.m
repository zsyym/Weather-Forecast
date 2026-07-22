//
//  DailyForecastModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "DailyForecastModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DailyForecastModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    DailyForecastModel* model = [[DailyForecastModel alloc] init];
    model.date = dict[@"date"] ?: @"";
    NSDictionary* day = dict[@"day"];
    if ([day isKindOfClass:[NSDictionary class]]) {
        model.maxTempC = [day[@"maxtemp_c"] doubleValue];
        model.minTempC = [day[@"mintemp_c"] doubleValue];
        model.avgTempC = [day[@"avgtemp_c"] doubleValue];
        model.chanceOfRain = [day[@"daily_chance_of_rain"] integerValue];
        NSDictionary *condition = day[@"condition"];
        if ([condition isKindOfClass:[NSDictionary class]]) {
            model.conditionText = condition[@"text"] ?: @"";
            model.conditionCode = condition[@"code"] ?: @"";
            model.icon = [model iconWithCode:model.conditionCode];
        }
    }
    NSDictionary* astro = dict[@"astro"];
    if ([astro isKindOfClass:[NSDictionary class]]) {
        model.sunrise = astro[@"sunrise"] ?: @"";
        model.sunset = astro[@"sunset"] ?: @"";
    }
    NSDictionary* air = dict[@"air_quality"];
    model.airQuality = [AirQualityModel modelWithDictionary:air];
    NSMutableArray* hourArray = [NSMutableArray array];
    NSArray *hours = dict[@"hour"];
    if ([hours isKindOfClass:[NSArray class]]) {
        for (NSDictionary *hourDict in hours) {
            HourWeatherModel *hour = [HourWeatherModel modelWithDictionary:hourDict];
            [hourArray addObject:hour];
        }
    }
    model.hours = hourArray;
    return model;
}
-(NSString *)weekdayWithDate:(NSString *)date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate* dateObj = [formatter dateFromString:date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:dateObj];
    switch (weekday) {
        case 1:
            return @"周日";
        case 2:
            return @"周一";
        case 3:
            return @"周二";
        case 4:
            return @"周三";
        case 5:
            return @"周四";
        case 6:
            return @"周五";
        case 7:
            return @"周六";
        default:
            return @"";
    }
}
-(NSString *)iconWithCode:(NSString *)conditionCode {
    NSInteger code = [conditionCode integerValue];
    switch (code) {
        case 1000:
            return @"sun.max.fill";
        case 1003:
        case 1006:
        case 1009:
            return @"cloud.fill";
        case 1030:
        case 1135:
        case 1147:
            return @"cloud.fog.fill";
        case 1063:
        case 1150:
        case 1153:
        case 1168:
        case 1171:
        case 1180:
        case 1183:
        case 1186:
        case 1189:
        case 1192:
        case 1195:
        case 1198:
        case 1201:
        case 1240:
        case 1243:
        case 1246:
            return @"cloud.rain.fill";
        case 1066:
        case 1114:
        case 1117:
        case 1210:
        case 1213:
        case 1216:
        case 1219:
        case 1222:
        case 1225:
        case 1255:
        case 1258:
            return @"snowflake";
        case 1069:
        case 1204:
        case 1207:
        case 1249:
        case 1252:
            return @"cloud.sleet.fill";
        case 1087:
        case 1273:
        case 1276:
            return @"cloud.bolt.fill";
        case 1012:
        case 1015:
        case 1018:
        case 1021:
        case 1024:
        case 1027:
        case 1033:
        case 1036:
        case 1039:
        case 1042:
        case 1045:
        case 1048:
            return @"sun.haze.fill";

        case 1072:
            return @"cloud.drizzle.fill";
        case 1237:
        case 1261:
        case 1264:
            return @"cloud.hail.fill";

        case 1279:
        case 1282:
            return @"cloud.bolt.fill";
        default:
            return @"cloud.fill";
    }
}
@end

NS_ASSUME_NONNULL_END
