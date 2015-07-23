//
//  HeadView.m
//  DJBookReader
//
//  Created by user on 15/7/23.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.text = @"haha";
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blueColor];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}

@end
