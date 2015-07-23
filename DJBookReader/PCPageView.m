//
//  PCPageView.m
//  PCPageDemo
//
//  Created by 张培创 on 15/3/10.
//  Copyright (c) 2015年 com.duowan. All rights reserved.
//

#import "PCPageView.h"
#import <CoreText/CoreText.h>

@implementation PCPageView

- (void)setText:(NSAttributedString *)attributedText
{
    self.attributedText = attributedText;
    [self setNeedsDisplay];
}


@end
