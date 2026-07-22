//
//  SearchViewController.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/16.
//

#import <UIKit/UIKit.h>
#import "totalWeatherModel.h"
#import "weatherDetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController

@property(nonatomic, strong) UITableView* cityListTableview;
@property(nonatomic, strong) NSMutableArray* searchResults;
@property (nonatomic, copy) NSString *lastSearchText;
@property(nonatomic, assign) BOOL isLoading;
- (void)searchCityWithText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
