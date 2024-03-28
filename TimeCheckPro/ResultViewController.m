//
//  ResultViewController.m
//  TimeCheckPro
//
//  Created by K S on R 6/03/27.
//

#import "ResultViewController.h"
#import "Time.h"

@interface ResultViewController ()
@property (nonatomic,strong)NSMutableArray* times;
@property (nonatomic,strong)NSString *path;
@property (nonatomic,strong)NSString *key;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //格納パスを取得、なければ作る
    self.path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"time.data"];
    self.key = @"times";
    Time *time = [[Time alloc]init];
    self.times = [time getTimeDataWithPath:self.path key:self.key];
    
    [_tableView reloadData];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellStr = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    Time *time = self.times[indexPath.row];
    NSString *str = @"";
    if (time.isIncluded) {
        str = [NSString stringWithFormat:@"%ld 時が%ld 時と%ld 時に含まれる",time.inputTime,time.startTime,time.endTime];
    } else {
        str = [NSString stringWithFormat:@"%ld 時が%ld 時と%ld 時に含まれてない",time.inputTime,time.startTime,time.endTime];
    }
    cell.textLabel.text = str;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.times.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:NO animated:YES];
    [self.times removeObjectAtIndex:indexPath.row];
    Time *time = [[Time alloc]init];
    [time savaTimeData:self.times path:self.path key:self.key];
    [_tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
