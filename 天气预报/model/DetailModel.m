//
//  DetailModel.m
//  天气预报
//
//  Created by MacBook Air on 2026/7/20.
//

#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DetailModel

+(instancetype)modelWithDictionary:(NSDictionary *)dict {
    DetailModel *model = [[DetailModel alloc] init];
    model.titleArray = dict[@"title"];
    model.imageArray = dict[@"image"];
    model.dataDescriptionArray = dict[@"dataDescription"];
    model.dataArray = [NSMutableArray array];
    for (id obj in dict[@"data"]) {
        [model.dataArray addObject: [NSString stringWithFormat:@"%@", obj]];
    }
    return model;
}
                                                         
                                                         
@end

NS_ASSUME_NONNULL_END
