//
//  NoteTableViewController.m
//  TODO
//
//  Created by chenguandong on 15/4/21.
//  Copyright (c) 2015年 chenguandong. All rights reserved.
//

#import "NoteTableViewController.h"
#import <MJRefresh.h>
#import "NoteTableViewControllerViewModel.h"
#import "NoteTableViewCell.h"
@interface NoteTableViewController ()
@property(strong,nonatomic)UILabel *headerLable;

@property(nonatomic,strong)NoteTableViewControllerViewModel *viewModel;

@end

@implementation NoteTableViewController


-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _viewModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _viewModel = [[NoteTableViewControllerViewModel alloc]init];
    [self setRefreshView];

    //[self setRefreshFootView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setBackgroundColor:[UIColor redColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [_viewModel queryNoteData:nil];
    
    [self.tableView reloadData];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)setRefreshView{
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    NSArray *images = @[[UIImage imageNamed:@"iconfont-note"]];
    
   
    //,[UIImage imageNamed:@"iconfont-bijiben"]
    
    [self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(createNewNote)];
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


-(void)setRefreshFootView{
    
    NSArray *images = @[[UIImage imageNamed:@"iconfont-setting"]];
    
    
    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(goSetting)];
    

    
    self.tableView.gifFooter.refreshingImages = images;
   

    // 隐藏状态
    self.tableView.footer.stateHidden = YES;
}

-(void)goSetting{

    [self.tableView.footer endRefreshing];
}

-(void)createNewNote{
    
    [self.tableView.header endRefreshing];
    [self performSegueWithIdentifier:@"Write" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_viewModel getNumberOfRowsInSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [_viewModel getTableViewCell:tableView :indexPath ];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        
        [_viewModel deleteNote:_viewModel.array[indexPath.row]];
        [_viewModel queryNoteData:nil];
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
