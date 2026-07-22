//
//  HourCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "HourCell.h"
#import <Masonry/Masonry.h>
@implementation HourCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemUltraThinMaterialDark];
        self.glassView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.glassView.layer.cornerRadius = 15;
        self.glassView.clipsToBounds = YES;
        [self.contentView addSubview:self.glassView];
        [self.glassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(60, 100);
        self.backgroundColor = [UIColor clearColor];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[HourItemCell class] forCellWithReuseIdentifier:@"hourItemCell"];
        [self.glassView.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hours.count;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HourItemCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hourItemCell" forIndexPath:indexPath];
    cell.model = self.hours[indexPath.item];
    return cell;
}
@end
