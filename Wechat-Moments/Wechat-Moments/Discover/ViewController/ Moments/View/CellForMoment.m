//
//  CellForMoment.m
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMoment.h"

@implementation CellForMoment

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    
    return self;
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
}



@end
