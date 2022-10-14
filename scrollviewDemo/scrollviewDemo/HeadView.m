//
//  HeadView.m
//  scrollviewDemo
//
//  Created by xiong on 2022/10/14.
//

#import "HeadView.h"
#import <Masonry.h>

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.titleL = [[UILabel alloc] init];
    self.titleL.text = @"多年来，Google让人难以将广告和有机搜索结果一目了然地分开。在目前的迭代中，当用户进行搜索时，两者之间唯一的区别是用粗体字写的\"广告\"--而且很容易错过。今天，这家搜索巨头正在对这一点进行小的改变，在搜索结果中出现的广告旁边，用粗体的\"赞助\"标签取代了\"广告\"标签。";
    self.titleL.font = [UIFont systemFontOfSize:13];
    self.titleL.textColor = [UIColor blackColor];
    self.titleL.backgroundColor = [UIColor brownColor];
    self.titleL.numberOfLines = 0;
    
    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.bottom.right.mas_equalTo(-20);
    }];


}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleL.preferredMaxLayoutWidth = self.frame.size.width - 40;
}
@end
