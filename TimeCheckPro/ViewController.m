//
//  ViewController.m
//  TimeCheckPro
//
//  Created by K S on R 6/03/26.
//

#import "ViewController.h"
#import "Time.h"
#import "ResultViewController.h"

@interface ViewController ()

- (IBAction)checkButtion:(id)sender;
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputTime;
@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UILabel *displayMessage;
@property (nonatomic,strong)NSString *path;
@property (nonatomic,strong)NSString *key;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //格納パスを取得、なければ作る
    self.path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"time.data"];
    self.key = @"times";
}


- (IBAction)saveButton:(id)sender {
    //NSLog(@"保存が押下された");
    ResultViewController *resultTableView = [[ResultViewController alloc]init];
    [self.navigationController pushViewController:resultTableView animated:YES];
    resultTableView.title = @"時刻判定履歴";
}

- (IBAction)checkButtion:(id)sender {
    //NSLog(@"判定がが押下された");
    NSMutableArray *times = [[NSMutableArray alloc]init];
    NSString *inputTimeStr = self.inputTime.text;
    NSString *startTimeStr = self.startTime.text;
    NSString *endTimeStr = self.endTime.text;
    
    NSInteger inputTimeInt = [inputTimeStr integerValue];
    NSInteger startTimeInt = [startTimeStr integerValue];
    NSInteger endTimeInt = [endTimeStr integerValue];
    
    //times = [self getTimeData];
    Time *time = [[Time alloc]initWithinputTime:inputTimeInt startTime:startTimeInt endTime:endTimeInt];
    time.isIncluded = NO;
    //データをローカルから取得
    times = [time getTimeDataWithPath:self.path key:self.key];
    if (startTimeInt == endTimeInt) {
        //NSLog(@"開始時刻と終了時刻が同じにしてはいけない");
        self.displayMessage.text = @"開始時刻と終了時刻が同じにしてはいけない";
    } else if (startTimeInt > endTimeInt) {
        //NSLog(@"開始時刻が終了時刻より小さくしてください");
        self.displayMessage.text = @"開始時刻が終了時刻より小さくしてください";
    } else if (inputTimeInt >= startTimeInt && inputTimeInt < endTimeInt ) {
        //NSLog(@"時刻が含まれる");
        NSString *message = [@""  stringByAppendingFormat:@"%ld時が%ld時、%ld時に含まれてる。",inputTimeInt,startTimeInt,endTimeInt];
        [self.displayMessage setText:message];
        time.isIncluded = YES;
        [times addObject:time];
    } else {
        //NSLog(@"時刻が含まれていない");
        NSString *message = [@""  stringByAppendingFormat:@"%ld時が%ld時、%ld時に含まれていない。",inputTimeInt,startTimeInt,endTimeInt];
        [self.displayMessage setText:message];
        [times addObject:time];
    }
    //データをローカルに保存
    [time savaTimeData:times path:self.path key:self.key];
}
@end
