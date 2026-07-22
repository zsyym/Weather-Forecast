//
//  weatherDetailViewController.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "WeatherAPIService.h"
#import "DetailModel.h"
#import "CityModel.h"
#import "SavedCityStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface weatherDetailViewController : UIViewController

@property(nonatomic, strong) totalWeatherModel* model;
@property(nonatomic, strong) DetailModel* detailModel;
@property(nonatomic, strong) UIImageView* backgroundImage;
@property(nonatomic, strong) CityModel* cityModel;
@end

NS_ASSUME_NONNULL_END
