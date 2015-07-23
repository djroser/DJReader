//
//  ReadMark.h
//  DJBookReader
//
//  Created by user on 15/7/22.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ReadMark : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger lastRead;

@property (nonatomic, assign) NSInteger mark1;

@property (nonatomic, assign) NSInteger mark2;

@property (nonatomic, assign) NSInteger mark3;

@end
