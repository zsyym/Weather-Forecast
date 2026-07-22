//
//  HourItemCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/18.
//

#import <UIKit/UIKit.h>
#import "HourWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HourItemCell : UICollectionViewCell

@property(nonatomic, strong) UILabel* hour;
@property(nonatomic, strong) UILabel* tempC;
@property(nonatomic, strong) UILabel* chanceOfRain;
@property(nonatomic, strong) UIImageView* icon;
@property(nonatomic, strong) HourWeatherModel* model;

-(void)setModel:(HourWeatherModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
