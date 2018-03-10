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
   
    commentView = [[UIView alloc]init];
    commentView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:commentView];
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
   
    if (model.comments != NULL) {
        if (model.images.count <= 3) {
            for (NSMutableDictionary *dic in model.comments) {
               
                commentModel *commentmodel = [[commentModel alloc ]init];
                [commentmodel setValuesForKeysWithDictionary:dic];
                [self.contentArray addObject:commentmodel];
            }
            NSInteger count = self.contentArray.count;
            commentView.sd_layout
            .leftEqualToView(contentLabel)
            .rightSpaceToView(self.contentView, 10)
            .heightIs( 30 * count)
            .topSpaceToView(contentLabel,(kScreenWidth - 80 -20) / 3 + 10 + 10);
            for (int i  = 0; i < self.contentArray.count; i++) {
                UILabel *content = [[UILabel alloc]init];
                commentModel *commentmodel = [[commentModel alloc ]init];
                commentmodel = self.contentArray[i];
                content.text = commentmodel.content;
                content.textColor = [UIColor blackColor];
                [commentView addSubview:content];
                [content mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(commentView.mas_top).offset(3+30*i);
                    make.left.equalTo(commentView.mas_left).offset(10);
                }];
               
            }
        }
        else if (model.images.count <= 6){
            
            commentView.sd_layout
            .leftEqualToView(contentLabel)
            .rightSpaceToView(self.contentView, 10)
            .heightIs(30)
            .topSpaceToView(contentLabel,(kScreenWidth - 80 -20) / 3 * 2+ 20 + 10);
        }
        
        [self setupAutoHeightWithBottomView:commentView bottomMargin:10];
    }else{
       [self setupAutoHeightWithBottomView:self.pictureView bottomMargin:10];
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
