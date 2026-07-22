//
//  WeatherAPIService.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "WeatherAPIService.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const WeatherAPIKey = @"4c2ca94c4adb42ed90833902262107";
static NSString * const WeatherBaseURL = @"https://api.weatherapi.com/v1/forecast.json";
static NSString * const SearchBaseURL = @"https://api.weatherapi.com/v1/search.json";

@implementation WeatherAPIService

static WeatherAPIService *_instance;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedManager];
}
-(void)fetchCurrentWeatherWithCity:(NSString *)latLonQuery completion:(void (^)(CurrentWeatherModel * _Nullable model, NSError * _Nullable error))completion {
    NSURLComponents *components = [NSURLComponents componentsWithString:WeatherBaseURL];
    components.queryItems = @[[NSURLQueryItem queryItemWithName:@"key" value:WeatherAPIKey],[NSURLQueryItem queryItemWithName:@"q" value:latLonQuery],[NSURLQueryItem queryItemWithName:@"days" value:@"1"],[NSURLQueryItem queryItemWithName:@"lang" value:@"zh"]];//查询参数拼接
    NSURL* url = components.URL;
    if (!url) {
        NSLog(@"URL构造失败");
        return;
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = 15.0;
    request.HTTPMethod = @"GET";
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //三种不同错误的判别
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
            return;
        }
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSDictionary* errorDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString* msg = errorDict[@"error"][@"message"];
            NSError* apiError = [NSError errorWithDomain:@"WeatherAPIService" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey:msg}];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,apiError);
            });
            return;
        }
        NSError* jsonError;
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError || ![jsonDict isKindOfClass:[NSDictionary class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,jsonError);
                return;
            });
        }
        CurrentWeatherModel* model = [CurrentWeatherModel modelWithDictionary:jsonDict];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(model,nil);
            return;
        });
    }];
    [task resume];
}

-(void)searchCityWithKeyword:(NSString *)keyword completion:(void (^)(NSArray<CityModel *> * _Nullable, NSError * _Nullable))completion {
    NSURLComponents* components = [NSURLComponents componentsWithString:SearchBaseURL];
    components.queryItems = @[[NSURLQueryItem queryItemWithName:@"key" value:WeatherAPIKey],[NSURLQueryItem queryItemWithName:@"q" value:keyword]];
    NSURL* url = components.URL;
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10.0;
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
            return;
        }
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSDictionary* errorDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString* msg = errorDict[@"error"][@"message"];
            NSError* apiError = [NSError errorWithDomain:@"WeatherAPIService" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey:msg}];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,apiError);
            });
            return;
        }
        NSError* jsonError;
        NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];//这里是用NSArray接受
        if (jsonError || ![jsonResult isKindOfClass:[NSArray class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,jsonError);
                });
            return;
        }
        NSMutableArray<CityModel *>* cities = [NSMutableArray arrayWithCapacity:jsonResult.count];
        for (NSDictionary* dict in jsonResult) {
            if ([dict isKindOfClass:[NSDictionary class]]) {
                [cities addObject:[CityModel modelWithDictionary:dict]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion([cities copy],nil);
        });
    }];
    [sessionTask resume];
}
-(void)fetchTotalWeatherWithCity:(NSString *)latLonQuery completion:(void (^)(totalWeatherModel * _Nullable, NSError * _Nullable))completion {
    NSURLComponents *components = [NSURLComponents componentsWithString:WeatherBaseURL];
    components.queryItems = @[[NSURLQueryItem queryItemWithName:@"key" value:WeatherAPIKey],[NSURLQueryItem queryItemWithName:@"q" value:latLonQuery],[NSURLQueryItem queryItemWithName:@"days" value:@"7"],[NSURLQueryItem queryItemWithName:@"lang" value:@"zh"]];//查询参数拼接
    NSURL* url = components.URL;
    if (!url) {
        NSLog(@"URL构造失败");
        return;
    }
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.timeoutInterval = 15.0;
    request.HTTPMethod = @"GET";
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //三种不同错误的判别
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
            return;
        }
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSDictionary* errorDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString* msg = errorDict[@"error"][@"message"];
            NSError* apiError = [NSError errorWithDomain:@"WeatherAPIService" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey:msg}];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,apiError);
            });
            return;
        }
        NSError* jsonError;
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError || ![jsonDict isKindOfClass:[NSDictionary class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,jsonError);
                return;
            });
        }
        totalWeatherModel* model = [totalWeatherModel modelWithDictionary:jsonDict];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(model,nil);
            return;
        });
    }];
    [task resume];
}
@end

NS_ASSUME_NONNULL_END
