//
//  sevenDayCollectionViewCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/21.
//

#import "sevenDayCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "DayCell.h"
@implementation sevenDayCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleSystemThinMaterialDark];
        self.glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.glassView.layer.cornerRadius = 15;
        self.glassView.clipsToBounds = YES;
        [self.contentView addSubview:self.glassView];
        [self.glassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.backgroundColor = UIColor.clearColor;
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.glassView.contentView addSubview:self.tableview];
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.glassView);
        }];
        [self.tableview registerClass:[DayCell class] forCellReuseIdentifier:@"dayCell"];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DayCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell" forIndexPath:indexPath];
    cell.model = self.model.forecastArray[indexPath.item];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
