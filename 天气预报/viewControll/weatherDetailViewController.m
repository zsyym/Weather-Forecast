//
//  weatherDetailViewController.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "weatherDetailViewController.h"
#import "HeaderCell.h"
#import "HourCell.h"
#import "sevenDayCollectionViewCell.h"
#import "AirCell.h"
#import "DetailCell.h"
#import <Masonry/Masonry.h>

@interface weatherDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView* collectionView;

@end

@implementation weatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![SavedCityStore isAdd:self.cityModel]) {
        UIBarButtonItem* addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity)];
        self.navigationItem.rightBarButtonItem = addItem;
    } else {
        UIBarButtonItem* deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCity)];
        self.navigationItem.rightBarButtonItem = deleteItem;
    }
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImage.clipsToBounds = YES;
    self.backgroundImage.image = [UIImage imageNamed:[self backgroundImageWithCode:self.model.currentModel.conditionCode]];
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self setUpCollectionView];
    [self setDetailModel];
}
-(void)setDetailModel{
    NSDictionary* dict = @{@"title":@[@"体感温度",@"紫外线指数",@"风速", @"日出",@"日落",@"降水量",@"能见度",@"湿度",@"平均温度",@"气压"],@"image":@[@"thermometer.variable.and.figure",@"rainbow",@"wind",@"sunrise.fill",@"sunset.fill",@"drop.fill",@"eye.fill",@"humidity",@"chart.line.uptrend.xyaxis",@"gauge.with.dots.needle.bottom.50percent",],@"data":@[@(self.model.currentModel.feelsLikeC),@(self.model.currentModel.uvIndex),@(@(self.model.currentModel.windKph).integerValue),self.model.forecastArray[0].sunrise,self.model.forecastArray[0].sunset,@(self.model.currentModel.precipMm),@(self.model.currentModel.visKm),@(self.model.currentModel.humidity),@(self.model.forecastArray[0].avgTempC),@(self.model.currentModel.pressureMb)],@"dataDescription":@[@"体感温度更高",@"注意防晒",@"",@"",@"",@"",@"",@"",@"",@""]};
    self.detailModel = [DetailModel modelWithDictionary:dict];
}
-(void)setUpCollectionView {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"headerCell"];
    [self.collectionView registerClass:[AirCell class] forCellWithReuseIdentifier:@"airCell"];
    [self.collectionView registerClass:[HourCell class] forCellWithReuseIdentifier:@"hourCell"];
    [self.collectionView registerClass:[sevenDayCollectionViewCell class] forCellWithReuseIdentifier:@"sevenDayCell"];
    [self.collectionView registerClass:[DetailCell class] forCellWithReuseIdentifier:@"detailCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HeaderCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        cell.model = self.model.currentModel;
        return cell;
    }
    if (indexPath.section == 1) {
        HourCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hourCell" forIndexPath:indexPath];
        cell.hours = [self sethours];
        return cell;
    }
    if (indexPath.section == 2) {
        sevenDayCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sevenDayCell" forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.section == 3) {
        AirCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"airCell" forIndexPath:indexPath];
        cell.model = self.model.currentModel.airQuality;
        return cell;
    }
    DetailCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.title.text = self.detailModel.titleArray[indexPath.item];
    UIImageSymbolConfiguration* config = [UIImageSymbolConfiguration configurationPreferringMulticolor];
    UIImage* image = [[UIImage systemImageNamed:self.detailModel.imageArray[indexPath.item]] imageByApplyingSymbolConfiguration:config];
    cell.imageview.image = image;
    cell.dataDescription.text = self.detailModel.dataDescriptionArray[indexPath.item];
    cell.data.text = self.detailModel.dataArray[indexPath.item];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    return 10;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColor.whiteColor;
    label.font = [UIFont boldSystemFontOfSize:18];

    switch (indexPath.section) {
        case 1:
            label.text = @"24小时天气";
            break;
        case 2:
            label.text = @"7日天气预报";
            break;
        case 3:
            label.text = @"空气质量";
            break;
        default:
            break;
    }
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.bottom.equalTo(view).offset(-5);
    }];
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 4) {
        return CGSizeZero;
    }
    return CGSizeMake(collectionView.bounds.size.width, 40);
}
-(NSArray*)sethours{
    NSMutableArray* array = [NSMutableArray array];
    NSString* time = self.model.currentModel.localTime;
    NSArray *components = [time componentsSeparatedByString:@" "];
    NSString *timeStr = components.count > 1 ? components[1] : time;
    // 再按 : 分割
    NSArray *hourComponents = [timeStr componentsSeparatedByString:@":"];
    NSString *hourStr = hourComponents.count > 1 ? hourComponents[0] : timeStr;
    NSInteger hour = [hourStr integerValue];
    for (NSInteger i = hour; i < 24 ; i++) {
        [array addObject:self.model.forecastArray[0].hours[i]];
    }
    for (NSInteger i = 0; i < hour; i++) {
        [array addObject:self.model.forecastArray[1].hours[i]];
    }
    return array;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.bounds.size.width;
    if (indexPath.section == 0) {
        return CGSizeMake(width - 20, 180);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(width - 20, 120);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(width - 20, 450);
    }
    if (indexPath.section == 3) {
        return CGSizeMake(width - 20, 160);
    }
    // section4
    CGFloat itemWidth = (width - 30) / 2;
    return CGSizeMake(itemWidth, 150);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 4) {
        return UIEdgeInsetsMake(10, 10, 50, 10);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
-(NSString *)backgroundImageWithCode:(NSString *)conditionCode {
    NSInteger code = [conditionCode integerValue];
    switch (code) {
        case 1000:
            return @"sunny";
        case 1003:
        case 1006:
        case 1009:
            return @"cloudy";
        case 1030:
        case 1135:
        case 1147:
            return @"fog";
        case 1063:
        case 1150:
        case 1153:
        case 1168:
        case 1171:
        case 1180:
        case 1183:
        case 1186:
        case 1189:
        case 1192:
        case 1195:
        case 1198:
        case 1201:
        case 1240:
        case 1243:
        case 1246:
            return @"rain";
        case 1066:
        case 1114:
        case 1117:
        case 1210:
        case 1213:
        case 1216:
        case 1219:
        case 1222:
        case 1225:
        case 1255:
        case 1258:
            return @"snow";
        case 1069:
        case 1204:
        case 1207:
        case 1249:
        case 1252:
            return @"sleet";
        case 1087:
        case 1273:
        case 1276:
            return @"thunder";
        default:
            return @"default";
    }
}
-(void)addCity {
    [SavedCityStore addCity:self.cityModel];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"添加成功"message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction: [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    UIBarButtonItem* deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCity)];
    self.navigationItem.rightBarButtonItem = deleteItem;
}
-(void)deleteCity {
    [SavedCityStore removeCity:self.cityModel];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"删除成功"message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction: [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    UIBarButtonItem* addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity)];
    self.navigationItem.rightBarButtonItem = addItem;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
