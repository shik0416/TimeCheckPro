//
//  Time.h
//  TimeCheckPro
//
//  Created by K S on R 6/03/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Time : NSObject<NSCoding>
@property(nonatomic,assign)NSInteger inputTime;
@property(nonatomic,assign)NSInteger startTime;
@property(nonatomic,assign)NSInteger endTime;
@property(nonatomic)Boolean isIncluded;

- (instancetype)initWithinputTime:(NSInteger)inputTime
                        startTime:(NSInteger)startTime
                          endTime:(NSInteger)endTime;

//データローカルに保存
- (void)savaTimeData:(NSMutableArray *)times
                path:(NSString *)path
                 key:(NSString *)key;
//ローカルからデータ取得
- (NSMutableArray *)getTimeDataWithPath:(NSString *)path
                                    key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
