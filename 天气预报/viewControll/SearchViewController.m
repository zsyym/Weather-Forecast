//
//  SearchViewController.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/16.
//

#import "SearchViewController.h"
#import <Masonry/Masonry.h>
#import "searchTableViewCell.h"
#import "WeatherAPIService.h"

@interface SearchViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor blackColor];
    self.searchResults = [NSMutableArray array];
    [self setupTableView];
}
-(void)searchCityWithText:(NSString *)text {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performSearchWithText:) object:self.lastSearchText];
    self.lastSearchText = text;
    if (text.length == 0) {
        [self.searchResults removeAllObjects];
        [self.cityListTableview reloadData];
        return;
    }
    [self performSelector:@selector(performSearchWithText:) withObject:text afterDelay:0.3];
}
- (void)performSearchWithText:(NSString *)text {
    __weak typeof(self) weakSelf = self;
    [[WeatherAPIService sharedManager] searchCityWithKeyword:text completion:^(NSArray<CityModel *> * _Nullable cities, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (error) {
            NSLog(@"搜索失败: %@", error.localizedDescription);
            return;
        }
        strongSelf.searchResults = [cities mutableCopy];
        [strongSelf.cityListTableview reloadData];
    }];
}
-(void)setupTableView{
    self.cityListTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.cityListTableview.delegate = self;
    self.cityListTableview.dataSource = self;
    self.cityListTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.cityListTableview registerClass:[searchTableViewCell class] forCellReuseIdentifier:@"searchCell"];
    [self.view addSubview:self.cityListTableview];
    [self.cityListTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    searchTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    CityModel* model = self.searchResults[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isLoading) {
        return;
    }
    self.isLoading = YES;
    CityModel* city = self.searchResults[indexPath.row];
    NSString *latLonQuery = [NSString stringWithFormat:@"%f,%f", city.cityLat, city.cityLon];
    __weak typeof(self)weakSelf = self;
    [[WeatherAPIService sharedManager] fetchTotalWeatherWithCity:latLonQuery completion:^(totalWeatherModel * _Nullable model, NSError * _Nullable error) {
        self.isLoading = NO;
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if (error) {
            NSLog(@"查询失败: %@",error.localizedDescription);
            return;
        }
        weatherDetailViewController *detailVC =[[weatherDetailViewController alloc] init];
        detailVC.model = model;
        detailVC.cityModel = city;
        UINavigationController *nav = nil;
        UIResponder *responder = self;
        while (responder) {
            if ([responder isKindOfClass:[UINavigationController class]]) {
                nav = (UINavigationController *)responder;
                break;
            }
            responder = responder.nextResponder;
        }
        if (nav) {
            [nav pushViewController:detailVC animated:YES];
        }
    }];
}

@end
