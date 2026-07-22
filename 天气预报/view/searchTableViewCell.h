//
//  searchTableViewCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface searchTableViewCell : UITableViewCell

@property(nonatomic, strong) CityModel* model;
@property(nonatomic, strong) UILabel* cityName;

@end

NS_ASSUME_NONNULL_END
