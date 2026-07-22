//
//  HourWeatherModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "HourWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HourWeatherModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    HourWeatherModel* model = [[HourWeatherModel alloc] init];
    model.time = dict[@"time"] ?: @"";
    model.tempC = [dict[@"temp_c"] doubleValue];
    model.chanceOfRain = [dict[@"chance_of_rain"] integerValue];
    NSDictionary *condition = dict[@"condition"];
    if ([condition isKindOfClass:[NSDictionary class]]) {
        model.conditionText = condition[@"text"] ?: @"";
        model.conditionCode = condition[@"code"] ?: @"";
    }
    model.icon = [model iconWithCode:model.conditionCode];
    return model;
}
-(NSString *)displayHourString:(NSString*)time{
    // "2026-07-15 14:00" 取空格后面的 "14:00"
    NSArray *components = [time componentsSeparatedByString:@" "];
    NSString *timeStr = components.count > 1 ? components[1] : time;
    // 再按 : 分割
    NSArray *hourComponents = [timeStr componentsSeparatedByString:@":"];
    return hourComponents.count > 0 ? [NSString stringWithFormat:@"%@时", hourComponents[0]] : timeStr;
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
