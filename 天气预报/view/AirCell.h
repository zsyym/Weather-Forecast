//
//  AirCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "AirQualityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AirCell : UICollectionViewCell

@property(nonatomic,strong) AirQualityModel* model;
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UILabel *pm2_5Label;
@property(nonatomic, strong) UILabel *pm10Label;
@property(nonatomic, strong) UILabel *coLabel;
@property(nonatomic, strong) UILabel *no2Label;
@property(nonatomic, strong) UILabel *so2Label;
@property(nonatomic, strong) UILabel *o3Label;
@property(nonatomic, strong) UIImageView* aqiIcon;
@property(nonatomic, strong) UIVisualEffectView *glassView;

@end

NS_ASSUME_NONNULL_END
