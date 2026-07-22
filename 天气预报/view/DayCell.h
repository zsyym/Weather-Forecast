//
//  DayCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "DailyForecastModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DayCell : UICollectionViewCell

@property(nonatomic, strong) DailyForecastModel* model;
@property(nonatomic, strong) UILabel* weekDay;
@property(nonatomic, strong) UILabel* tempC;
@property(nonatomic, strong) UILabel* chanceOfRain;
@property(nonatomic, strong) UILabel* maxTempC;
@property(nonatomic, strong) UILabel* minTempC;
@property(nonatomic, strong) UIImageView* icon;

@end

NS_ASSUME_NONNULL_END
