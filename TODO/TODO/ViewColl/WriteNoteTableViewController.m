//
//  WriteNoteTableViewController.m
//  TODO
//
//  Created by chenguandong on 15/4/23.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "WriteNoteTableViewController.h"
#import "WriteNoteTableViewControllerViewModel.h"
#import <MJRefresh.h>
@interface WriteNoteTableViewController ()
@property(nonatomic,strong)WriteNoteTableViewControllerViewModel *viewModel;
@end

@implementation WriteNoteTableViewController

-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _viewModel = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel =[[WriteNoteTableViewControllerViewModel alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    


    self.tableView.tableHeaderView = _textView;
    
    
    [self setRefreshView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)setRefreshView{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    NSArray *images = @[[UIImage imageNamed:@"iconfont-save"]];
    
   
    //,[UIImage imageNamed:@"iconfont-bijiben"]
    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(closeView)];
    // 设置普通状态的动画图片
    [self.tableView.gifHeader setImages:images forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableView.gifHeader setImages:images forState:MJRefreshHeaderStatePulling];
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:images forState:MJRefreshHeaderStateRefreshing];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    
}

-(void)closeView{
    if (_textView.text.length!=0) {
        [_viewModel insertDate:_textView.text andNoteColor:@1];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 0;
}





/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
