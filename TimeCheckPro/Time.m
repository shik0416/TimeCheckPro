//
//  Time.m
//  TimeCheckPro
//
//  Created by K S on R 6/03/27.
//

#import "Time.h"

@implementation Time

- (instancetype)initWithinputTime:(NSInteger)inputTime
                        startTime:(NSInteger)startTime
                          endTime:(NSInteger)endTime
{
    self = [super init];
    if(self){
        self.inputTime = inputTime;
        self.startTime = startTime;
        self.endTime = endTime;
        self.isIncluded = NO;
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeInteger:self.inputTime forKey:@"inputTime"];
    [coder encodeInteger:self.startTime forKey:@"startTime"];
    [coder encodeInteger:self.endTime forKey:@"endTime"];
    [coder encodeBool:self.isIncluded forKey:@"isIncluded"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if(self){
        self.inputTime = [coder decodeIntegerForKey:@"inputTime"];
        self.startTime = [coder decodeIntegerForKey:@"startTime"];
        self.endTime = [coder decodeIntegerForKey:@"endTime"];
        self.isIncluded = [coder decodeBoolForKey:@"isIncluded"];
    }
    return self;
}

//データローカルに保存
- (void)savaTimeData:(NSMutableArray *)times
                path:(NSString *)path
                 key:(NSString *)key {
    // 创建NSData(可变),NSKeyedArchiver(实现归档的对象)
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    // エンコーディング
    [archiver encodeObject:times forKey:key];
    [archiver finishEncoding];
    //ファイル保存
    [data writeToFile:path atomically:YES];
}

//ローカルからデータ取得
- (NSMutableArray *)getTimeDataWithPath:(NSString *)path
                                    key:(NSString *)key {
    // 创建NSData(可变), NSKeyedUnarchiver(实现反归档的对象)
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    // 反归档解码获取对象
    NSMutableArray *times = [unarchiver decodeObjectForKey:key];
    return times;
}


@end
