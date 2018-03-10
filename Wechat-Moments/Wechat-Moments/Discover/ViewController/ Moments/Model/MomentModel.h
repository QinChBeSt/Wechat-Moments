//
//  MomentModel.h
//  Wechat-Moments
//
//  Created by 钱程 on 2018/3/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenderModel.h"
@interface MomentModel : NSObject
//内容
@property (nonatomic , strong) NSString * content;
//图
@property (nonatomic , strong) NSArray *images;
//用户
@property (nonatomic , strong) NSMutableDictionary *sender;
//留言
@property (nonatomic , strong) NSMutableArray * comments;

@property (nonatomic , strong) NSString *error;

@end
