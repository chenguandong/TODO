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
#import "Constants.h"
CGFloat const cornerRadiusValue = 20;
@interface WriteNoteTableViewController ()
@property(nonatomic,strong)WriteNoteTableViewControllerViewModel *viewModel;
@property(nonatomic,assign)int colorValue;
@property(nonatomic,strong)NSArray *colorArr;
@end

@implementation WriteNoteTableViewController

-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _viewModel = nil;
    _noteModel = nil;
    _colorArr = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    if (_noteModel) {

        NSLog(@"你走了修改");
        
        _textView.text = _noteModel.note_content;
        
    }else{
       
        NSLog(@"你走的新建");
      //  [_textView becomeFirstResponder];
    }
    
    
    _viewModel =[[WriteNoteTableViewControllerViewModel alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:self.view.frame];
    
    bgImageView.image = [UIImage imageNamed:@"note_background"];
    
    self.tableView.backgroundView =bgImageView;
    
    
    self.textView.layer.borderColor = [UIColor clearColor].CGColor;
    self.textView.layer.borderWidth = 50;
    
    self.textView.layer.cornerRadius = 5;
    
    self.textView.layer.masksToBounds = YES;

    
    
    [self setRefreshView];
    
    [self initTextView];
    
    [self initColor];
    
}

-(BOOL)shouldAutorotate{
    
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
return UIInterfaceOrientationMaskPortrait;
}

-(void)initColor{
    
    _colorValue =[_noteModel.note_color intValue];
    
    _colorArr = @[
                  _buttonColor1.backgroundColor,
                  _buttonColor2.backgroundColor,
                  _buttonColor3.backgroundColor,
                  _buttonColor4.backgroundColor,
                  _buttonColor5.backgroundColor,
                  ];

    
    _textView.backgroundColor = _colorArr[_colorValue];
    
    _buttonColor1.layer.cornerRadius = cornerRadiusValue;
    _buttonColor2.layer.cornerRadius = cornerRadiusValue;
    _buttonColor3.layer.cornerRadius = cornerRadiusValue;
    _buttonColor4.layer.cornerRadius = cornerRadiusValue;
    _buttonColor5.layer.cornerRadius = cornerRadiusValue;
    
    [_buttonColor1 setTitle:@" " forState:UIControlStateNormal];
    [_buttonColor2 setTitle:@" " forState:UIControlStateNormal];
    [_buttonColor3 setTitle:@" " forState:UIControlStateNormal];
    [_buttonColor4 setTitle:@" " forState:UIControlStateNormal];
    [_buttonColor5 setTitle:@" " forState:UIControlStateNormal];

    
}
- (IBAction)changeTextViewBackgroundColor:(id)sender {
    
    if([sender isKindOfClass:[UIButton class]]){
        UIButton *button =sender;

        _colorValue = (int)button.tag ;
        
        
        NSLog(@"%ld",button.tag);
        
        _textView.backgroundColor = button.backgroundColor;
    
    }
        
  
    
}

-(void)initTextView{
    
    _textView.font = [UIFont systemFontOfSize:18.0f];
    _textView.textColor = [UIColor whiteColor];

/*
    _textView.isScrollable = YES;
    _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _textView.backgroundColor =[UIColor orangeColor];
    _textView.textColor =[UIColor whiteColor];
    _textView.minNumberOfLines = 15;
    _textView.maxNumberOfLines = 30;
    // you can also set the maximum height in points with maxHeight
    _textView.maxHeight = self.view.bounds.size.height/2;
    _textView.minHeight = self.view.bounds.size.height/2;
    _textView.returnKeyType = UIReturnKeyDefault; //just as an example
    _textView.font = [UIFont systemFontOfSize:18.0f];
    //_textView.delegate = self;
    _textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _textView.placeholder = @"请输入待办事项";
    _textView.placeholderColor = [UIColor whiteColor];
 
 */
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
   
    
    
    
    if (_noteModel) {
        
        if (![_textView.text isEqualToString:_noteModel.note_content]||(_colorValue!=[[_noteModel note_color] intValue])) {
            
            _noteModel.note_content = _textView.text;
            _noteModel.note_color = [NSNumber numberWithInt:_colorValue];
            NSError *error;
            if (![SharedApp.managedObjectContext save:&error]) {
                
                NSLog(@"update error, couldn't save: %@", [error localizedDescription]);
                
            }else{
                NSLog(@"update success....");
            }
        }
    }else{
        if (_textView.text.length!=0) {
            [_viewModel insertDate:_textView.text andNoteColor:[NSNumber numberWithInt:_colorValue]];

        }
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    _noteModel = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 0;
}


*/


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
