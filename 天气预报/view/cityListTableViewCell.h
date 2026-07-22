//
//  cityListTableViewCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface cityListTableViewCell : UITableViewCell

@property(nonatomic, strong) CurrentWeatherModel* model;
@property(nonatomic,strong) UIImageView *backgroundImage;
@property(nonatomic,strong) UILabel *cityName;
@property(nonatomic,strong) UILabel *localTime;
@property(nonatomic,strong) UILabel *currentTemp;
@property(nonatomic,strong) UILabel *maxAndMinTemp;
@property(nonatomic, strong) UILabel* conditionText;

-(void)setModel:(CurrentWeatherModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
