//
//  sevenDayCollectionViewCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/21.
//

#import <UIKit/UIKit.h>
#import "totalWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface sevenDayCollectionViewCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView* tableview;
@property(nonatomic,strong)UIVisualEffectView *glassView;
@property(nonatomic, strong)totalWeatherModel* model;
@end

NS_ASSUME_NONNULL_END
