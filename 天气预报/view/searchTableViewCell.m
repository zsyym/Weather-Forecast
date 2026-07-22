//
//  searchTableViewCell.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/17.
//

#import "searchTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation searchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cityName = [[UILabel alloc] init];
        self.cityName.textColor = [UIColor blackColor];
        self.cityName.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.cityName];
        [self.cityName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
-(void)setModel:(CityModel *)model {
    _model = model;
    self.cityName.text = [self.model displayFullName];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
