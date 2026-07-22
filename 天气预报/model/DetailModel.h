//
//  DetailModel.h
//  天气预报
//
//  Created by MacBook Air on 2026/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

@property(nonatomic, strong) NSArray* titleArray;
@property(nonatomic, strong) NSMutableArray* dataArray;
@property(nonatomic, strong) NSArray* imageArray;
@property(nonatomic, strong) NSArray* dataDescriptionArray;
+(instancetype)modelWithDictionary:(NSDictionary*) dict;

@end

NS_ASSUME_NONNULL_END
