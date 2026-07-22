//
//  DetailCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "DailyForecastModel.h"
#import "CurrentWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailCell : UICollectionViewCell

@property(nonatomic,strong) UILabel* title;
@property(nonatomic,strong) UILabel* data;
@property(nonatomic,strong) UIImageView* imageview;
@property(nonatomic,strong) UILabel* dataDescription;

@end

NS_ASSUME_NONNULL_END
