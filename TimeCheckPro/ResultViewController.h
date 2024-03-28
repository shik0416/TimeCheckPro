//
//  ResultViewController.h
//  TimeCheckPro
//
//  Created by K S on R 6/03/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
}
@end

NS_ASSUME_NONNULL_END
