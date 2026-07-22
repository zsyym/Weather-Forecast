//
//  weatherPageViewController.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface weatherPageViewController : UIPageViewController

@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) NSMutableArray* controllersArray;

@end

NS_ASSUME_NONNULL_END
