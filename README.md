# fix-tableHeaderView
## tableHeaderView 自动布局问题总结

- 约束冲突
- 页面显示时，header错位，展示不全
- header内如果有UILabel 需要换行时，需要设置`preferredMaxLayoutWidth`

### 主要代码如下：

```objective-c
//fix - 约束冲突
self.tableView.tableHeaderView = self.head;

[self.head mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(0).priorityMedium();
}];

//header错位，展示不全
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.head  layoutIfNeeded];
    self.tableView.tableHeaderView = self.head;
}

//headerView
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleL.preferredMaxLayoutWidth = self.frame.size.width - 40;
}

//利用KVO，在设置text时，重新赋值
@weakify(self)
[RACObserve(self.head.titleL, text) subscribeNext:^(id  _Nullable x) {
   @strongify(self)
   NSLog(@"%s",__func__);
   [self updateHeadView];
}];





```

