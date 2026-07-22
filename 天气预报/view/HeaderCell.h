//
//  HeaderCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "CurrentWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeaderCell : UICollectionViewCell

@property(nonatomic, strong) CurrentWeatherModel* model;
@property(nonatomic,strong) UILabel *cityName;
@property(nonatomic,strong) UILabel *currentTemp;
@property(nonatomic,strong) UILabel *maxAndMinTemp;
@property(nonatomic, strong) UILabel* conditionText;

-(void)setModel:(CurrentWeatherModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
