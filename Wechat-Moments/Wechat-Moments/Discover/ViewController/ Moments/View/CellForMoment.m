//
//  CellForMoment.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMoment.h"
@implementation CellForMoment{
    UIImageView *userIcon;
    UILabel *userName;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];
    }
    
    
    return self;
    
    
}
-(void)setupUI{
    userIcon = [[UIImageView alloc]init];
    [self.contentView addSubview:userIcon];
    userIcon.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .widthIs(50)
    .heightIs(50)
    .topSpaceToView(self.contentView, 20);
    
    
    userName = [[UILabel alloc]init];
    userName.textColor = [UIColor blueColor];
    [self.contentView addSubview:userName];
    userName.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(userIcon, 10);
   
    [self setupAutoHeightWithBottomView:userIcon bottomMargin:10];

}
-(void)setModel:(MomentModel *)model{
    NSLog(@"%@",model.sender[@"avatar"]);
    userName.text = model.sender[@"nick"];
    [userIcon sd_setImageWithURL:[NSURL URLWithString:model.sender[@"avatar"]] placeholderImage:[UIImage imageNamed:@"头像"]];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
