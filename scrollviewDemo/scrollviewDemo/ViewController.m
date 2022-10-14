//
//  ViewController.m
//  scrollviewDemo
//
//  Created by xiong on 2022/9/29.
//

#import "ViewController.h"
#import <Masonry.h>
#import "HeadView.h"
#import <ReactiveObjC.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

/// label 必须设置preferredMaxLayoutWidth
@property (nonatomic, strong) HeadView *head;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.head;
    //fix - 约束冲突
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0).priorityMedium();
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];


    //监听文字变化，冲洗赋值
    @weakify(self)
    [RACObserve(self.head.titleL, text) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"%s",__func__);
        [self updateHeadView];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",(long)indexPath.row];
    return cell;
}

/// 设置文字了后，需要重新赋值
- (void)updateHeadView{
    self.tableView.tableHeaderView = self.head;
}

/// 解决初始化，控件错位
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.head  layoutIfNeeded];
    self.tableView.tableHeaderView = self.head;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index = indexPath.row % 4;
    switch (index) {
        case 0:
            [self.head.titleL setText:@"发现在使用UITableView控件时候，self.tableView.tableHeaderView = self.viewHeader;控制台打印大量的约束冲突，但是界面完好。."];
            break;
        case 1:
            [self.head.titleL setText:@"self.tableView.tableHeaderView一开始尺寸为0.后来设置self.tableView.tableHeaderView = self.viewHeader;导致runLoop的一个循环周期内self.tableView.tableHeaderView的尺寸要进行变化。从0变化到self.viewHeader的尺寸"];
            break;
        case 2:
            [self.head.titleL setText:@"Example code for iOS 9, which assumes you have a UITableView passed into your method as tableView and an item to configure it as item:"];
            break;
        case 3:
            [self.head.titleL setText:@"当Google在2020年推出新的粗体\"广告\"标签时，许多人指出这一设计变化中的暗色图案，使用户眯起眼睛来分离出付费内容。但该公司花了两年时间才做出任何形式的改变"];
            break;
        default:
            [self.head.titleL setText:@"Definitely seeing this on a UITableView's tableHeaderView. I was able to get this to work with a custom header view by explicitly setting the width equal to that of the tableView after setting the tableHeaderView, THEN resetting it after a layout pass has completed."];
            break;
    }

   
}

-(HeadView *)head{
    if (!_head) {
        _head = [[HeadView alloc] initWithFrame:CGRectZero];
    }
    return _head;
    
}
@end
