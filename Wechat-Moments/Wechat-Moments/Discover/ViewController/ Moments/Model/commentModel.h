//
//  commentModel.h
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenderModel.h"
@interface commentModel : NSObject
@property (nonatomic , strong) NSString * content;
@property (nonatomic , strong) SenderModel *sender;
@end
