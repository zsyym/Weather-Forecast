//
//  HomeViewController.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/15.
//

#import "HomeViewController.h"
#import "cityListTableViewCell.h"
#import "WeatherAPIService.h"
#import "SearchViewController.h"
#import "weatherPageViewController.h"
#import <Masonry/Masonry.h>

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1 alpha:1];
    self.title = @"天气";
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    [appearance configureWithTransparentBackground];
    appearance.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    self.cityModelArray = [[SavedCityStore savedCities] mutableCopy];
    self.WeatherModelArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.cityModelArray.count; i++) {
        [self.WeatherModelArray addObject:[NSNull null]];
    }//先占位，防止顺序乱
    [self setUpTableView];
    [self loadWeather];
    SearchViewController* searchVC = [[SearchViewController alloc] init];
    self.searchControll = [[UISearchController alloc] initWithSearchResultsController:searchVC];
    self.searchControll.searchBar.showsBookmarkButton = YES;
    self.searchControll.searchBar.placeholder = @"搜索城市";
    self.searchControll.searchResultsUpdater = self;
    self.searchControll.obscuresBackgroundDuringPresentation = YES;
    self.navigationItem.searchController = self.searchControll;
    self.definesPresentationContext = YES;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *text = searchController.searchBar.text;
    SearchViewController *searchVC = (SearchViewController*)searchController.searchResultsController;
    [searchVC searchCityWithText:text];
}
- (void)loadWeather {
    __weak typeof(self)weakSelf = self;
    for (NSInteger i = 0; i < self.cityModelArray.count; i++) {
        CityModel* city = self.cityModelArray[i];
        NSString *latLonQuery = [NSString stringWithFormat:@"%f,%f", city.cityLat, city.cityLon];
        [[WeatherAPIService sharedManager] fetchCurrentWeatherWithCity:latLonQuery completion:^(CurrentWeatherModel * _Nullable model, NSError * _Nullable error) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            if (error) {
                NSLog(@"查询失败: %@",error.localizedDescription);
                return;
            }
            strongSelf.WeatherModelArray[i] = model;
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
            [strongSelf.cityTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityModelArray.count;
}
-(void)setUpTableView {
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.cityTableView];
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    [self.cityTableView registerClass:[cityListTableViewCell class] forCellReuseIdentifier:@"cityList"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cityListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cityList" forIndexPath:indexPath];
    id obj = self.WeatherModelArray[indexPath.section];
    if (![obj isKindOfClass:[NSNull class]]) {
        cell.model = obj;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction* deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSInteger index = indexPath.section;
        [SavedCityStore removeCity:self.cityModelArray[index]];
        [self.cityModelArray removeObjectAtIndex:index];
        [self.WeatherModelArray removeObjectAtIndex:index];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
        completionHandler(YES);
    }];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    config.performsFirstActionWithFullSwipe = YES;
    return config;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray* controllersArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.cityModelArray.count; i++) {
        [controllersArray addObject:[NSNull null]];
    }
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0;i < self.cityModelArray.count; i++) {
        CityModel* city = self.cityModelArray[i];
        NSString *latLonQuery = [NSString stringWithFormat:@"%f,%f", city.cityLat, city.cityLon];
        __weak typeof(self)weakSelf = self;
        dispatch_group_enter(group);
        [[WeatherAPIService sharedManager] fetchTotalWeatherWithCity:latLonQuery completion:^(totalWeatherModel * _Nullable model, NSError * _Nullable error) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (!strongSelf) {
                dispatch_group_leave(group);
                return;
            }
            if (error) {
                NSLog(@"查询失败: %@",error.localizedDescription);
                dispatch_group_leave(group);
                return;
            }
            weatherDetailViewController *detailVC =[[weatherDetailViewController alloc] init];
            detailVC.model = model;
            detailVC.cityModel = city;
            controllersArray[i] = detailVC;
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        weatherPageViewController* pageVC = [[weatherPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        pageVC.controllersArray = controllersArray;
        pageVC.currentIndex = indexPath.section;
        pageVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:pageVC animated:YES completion:nil];
    });//所有网络请求完成后才会调用
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.cityModelArray = [[SavedCityStore savedCities] mutableCopy];
    [self.WeatherModelArray removeAllObjects];
    for (NSInteger i = 0; i < self.cityModelArray.count; i++) {
        [self.WeatherModelArray addObject:[NSNull null]];
    }
    [self.cityTableView reloadData];
    [self loadWeather];
}
@end
