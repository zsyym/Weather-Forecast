//
//  HourCell.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import <UIKit/UIKit.h>
#import "HourWeatherModel.h"
#import "HourItemCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HourCell : UICollectionViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<HourWeatherModel *> *hours;

@end

NS_ASSUME_NONNULL_END
