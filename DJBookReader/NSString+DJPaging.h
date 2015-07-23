//
//  NSString+DJPaging.h
//  DJBookReader
//
//  Created by user on 15/7/21.
//  Copyright (c) 2015年 dingjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DJPaging)

- (NSArray *)paginationWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;


@end
