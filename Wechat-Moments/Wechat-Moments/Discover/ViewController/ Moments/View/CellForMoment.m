//
//  CellForMoment.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMoment.h"
#import "commentModel.h"
@interface CellForMoment ()
@property (nonatomic , strong) UIView *pictureView;
@property (nonatomic , strong) NSLayoutConstraint *bigPictureViewHeight;
@property (nonatomic , copy) NSMutableArray *contentArray;
@end

@implementation CellForMoment{
    UIImageView *userIcon;
    UILabel *userName;
    UILabel *contentLabel;
    UIView *commentView;
    NSMutableArray *pictureArray;
    UILabel *commentName;
    UILabel *commentText;
    
    
}
- (NSMutableArray *)contentArray
{
    if (!_contentArray)
    {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
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
    
    contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:contentLabel];
    contentLabel.sd_layout
    .leftEqualToView(userName)
    .topSpaceToView(userName, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
   
    
}
-(void)setModel:(MomentModel *)model{
   
    userName.text = model.sender[@"username"];
    contentLabel.text = model.content;
    [userIcon sd_setImageWithURL:[NSURL URLWithString:model.sender[@"avatar"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    
    NSMutableDictionary *dicUrl = [[NSMutableDictionary alloc]init];
    NSMutableArray *arrUrl = [[NSMutableArray alloc]init];
    for (dicUrl in model.images) {
        NSString *url = dicUrl[@"url"];
        [arrUrl addObject:url];
    }
    
    [self createPicTureView:arrUrl];
    [self commentview:model.comments];

}


    
- (void)commentview:(NSArray *)commentArr{
    [_contentArray removeAllObjects];
    commentView = [[UIView alloc]init];
    [self.contentView addSubview:commentView];
    if ([commentArr count] == 0) {
        [self setupAutoHeightWithBottomView:_pictureView bottomMargin:10];
        return;
    }
    else if ([commentArr count] == 1) {
        commentView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(_pictureView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(30);
        
        [self setupAutoHeightWithBottomView:commentView bottomMargin:10];
    }
    else if ([commentArr count] == 2) {
        commentView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(_pictureView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(60);
        [self setupAutoHeightWithBottomView:commentView bottomMargin:10];
    }
    else if ([commentArr count] == 3) {
        commentView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(_pictureView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(90);
        [self setupAutoHeightWithBottomView:commentView bottomMargin:10];
    }
    float x = 0;
    for (int i = 0; i < commentArr.count; i++) {
        x = i;
        UILabel *commentusername = [[UILabel alloc]init];
        NSMutableDictionary *dic = commentArr[i];
        NSMutableDictionary *namedic = dic[@"sender"];
        commentusername.textColor =[UIColor blueColor];
        commentusername.text = namedic[@"username"];
        NSLog(@"========%@",dic[@"content"]);
        [commentView addSubview:commentusername];
        [commentusername mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_pictureView.mas_bottom).offset(30 * x);
            make.left.equalTo(_pictureView);
            make.height.equalTo(@(30));
        }];
        
        UILabel *commentLabel = [[UILabel alloc]init];
        
        commentLabel.text = [NSString stringWithFormat:@":%@",dic[@"content"]];
        NSLog(@"========%@",dic[@"content"]);
        [commentView addSubview:commentLabel];
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_pictureView.mas_bottom).offset(30 * x);
            make.left.equalTo(commentusername.mas_right).offset(5);
            make.height.equalTo(@(30));
        }];
        
      
        
    }
}
- (void)createPicTureView:(NSArray *)picArray{
   
    [pictureArray removeAllObjects];

    CGFloat picWidth = (kScreenWidth - 80 -20) / 3;
    CGFloat picAddWIDTH = picWidth + 5;
    self.pictureView = [[UIView alloc]init];
    [self.contentView addSubview:self.pictureView];

    if ([picArray count]==0) {
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
       
        return ;
    }else if ([picArray count] == 1){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(picAddWIDTH);
        
    }else if ([picArray count] == 2){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(picAddWIDTH);
        
    }
    else if ([picArray count] == 3){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(picAddWIDTH);
        
    }else if ([picArray count] == 4){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(2 *picAddWIDTH);
        
    }else if ([picArray count] == 5){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(2 *picAddWIDTH);
        
    }
    else if ([picArray count] == 6){
        self.pictureView.sd_layout
        .leftEqualToView(contentLabel)
        .topSpaceToView(contentLabel, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(2 * picAddWIDTH);
        
    }
    float x=0;
    float y=0;
    for (int i =0 ; i<[picArray count]; i++) {
        
        if (i == 1) {
            x = picAddWIDTH;
            y = 0;
        }else if (i == 2){
            x= 2 * picAddWIDTH;
            y = 0;
        }else if (i == 3){
            x = 0;
            y = picAddWIDTH;
        }else if (i == 4){
            x = picAddWIDTH;
            y = picAddWIDTH;
        }else if (i == 5){
            x = picAddWIDTH * 2;
            y = picAddWIDTH;
        }else if (i == 6){
            x = 0;
            y = picAddWIDTH * 2;
        }else if (i == 7){
            x = picAddWIDTH;
            y = picAddWIDTH * 2;
        }else if (i == 8){
            x = picAddWIDTH * 2;
            y = picAddWIDTH * 2;
        }
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y , picWidth,picWidth)];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.clipsToBounds = YES;
        imageView.contentMode  =UIViewContentModeScaleAspectFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:picArray[i]] placeholderImage:[UIImage imageNamed:@"图片"]];
        [self.pictureView addSubview:imageView];
        [pictureArray addObject:imageView];
 
    }
    
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
