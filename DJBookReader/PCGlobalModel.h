//
//  PCGlobalModel.h
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//


#import <UIKit/UIKit.h>

static NSString *kUpdatePageNotification = @"kUpdatePageNotification";

@interface PCGlobalModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableArray *rangeArray;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSRange currentRange;     //尚未使用

+ (instancetype)shareModel;

- (void)loadText:(NSString *)text completion:(void(^)(void))completion;

- (void)updateFontCompletion:(void(^)(void))completion;

@end
