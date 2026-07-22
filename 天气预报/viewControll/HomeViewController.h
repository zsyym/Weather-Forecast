//
//  HomeViewController.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <UIKit/UIKit.h>
#import "SavedCityStore.h"
#import "CurrentWeatherModel.h"
#import "totalWeatherModel.h"
#import "weatherDetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property(nonatomic, strong) UITableView* cityTableView;
@property(nonatomic, strong) NSMutableArray* cityModelArray;
@property(nonatomic, strong) NSMutableArray* WeatherModelArray;
@property(nonatomic, strong) UISearchController* searchControll;

@end

NS_ASSUME_NONNULL_END
